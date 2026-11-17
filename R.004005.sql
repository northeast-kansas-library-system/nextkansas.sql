/*
R.004005

----------

Name: GHW - Home/Holding miss-match
Created by: George Williams

----------

Group: -
     -

Created on: 2026-10-22 22:37:29
Modified on: 2026-10-23 00:17:50
Date last run: 2026-10-23 00:14:59

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  items.barcode,
  homebranches.branchname AS HOME_BRANCH,
  holdingbranches.branchname AS CURRENT_BRANCH,
  CASE
    WHEN NullIf(items.permanent_location, '') IS NULL 
    THEN locations.lib
    WHEN NullIf(items.location, '') IS NULL 
    THEN permanent_location.lib
    WHEN items.permanent_location = items.location 
    THEN permanent_location.lib
    ELSE Concat(permanent_location.lib, ' (', locations.lib, ')')
  END AS LOCATION,
  itemtypes.description AS ITEM_TYPE,
  ccodes.lib AS COLLECTION_CODE,
  Concat_Ws(
    ' / ',
    If(
      NullIf(items.itemcallnumber, '') IS NOT NULL,
      Concat('Call number: ', items.itemcallnumber),
      NULL
    ),
    If(
      NullIf(items.enumchron, '') IS NOT NULL,
      Concat('Enumeration: ', items.enumchron),
      NULL
    ),
    If(
      NullIf(items.copynumber, '') IS NOT NULL,
      Concat('Copy number: ', items.copynumber),
      NULL
    )
  ) AS call_number_display,
  biblio.author,
  Concat_Ws( 
        " ", 
        biblio.title, 
        ExtractValue( 
          biblio_metadata.metadata, 
          '//datafield[@tag="245"]/subfield[@code="h"]' 
        ), 
        ExtractValue( 
          biblio_metadata.metadata, 
          '//datafield[@tag="245"]/subfield[@code="b"]' 
        ), 
        ExtractValue( 
          biblio_metadata.metadata, 
          '//datafield[@tag="245"]/subfield[@code="p"]' 
        ), 
        ExtractValue( 
          biblio_metadata.metadata, 
          '//datafield[@tag="245"]/subfield[@code="n"]' 
        ) 
      ) As FULL_TITLE,
  items.datelastseen AS LAST_SEEN_ON,
  CASE
    WHEN TimestampDiff(YEAR, items.datelastseen, Now()) > 0 
    THEN Concat(
      TimestampDiff(YEAR, items.datelastseen, Now()),
      ' years / ',
      MOD(
        TimestampDiff(MONTH, items.datelastseen, Now()),
        12
      ),
      ' months / ',
      MOD(
        TimestampDiff(DAY, items.datelastseen, Now()),
        30
      ),
      ' days'
    )
    WHEN TimestampDiff(MONTH, items.datelastseen, Now()) > 0 
    THEN Concat(
      TimestampDiff(MONTH, items.datelastseen, Now()),
      ' months / ',
      MOD(
        TimestampDiff(DAY, items.datelastseen, Now()),
        30
      ),
      ' days'
    )
    ELSE Concat(
      TimestampDiff(DAY, items.datelastseen, Now()),
      ' days'
    )
  END AS time_since_last_seen
FROM 
  biblio
  JOIN biblioitems ON biblioitems.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items ON items.biblionumber = biblio.biblionumber
  JOIN branches homebranches ON items.homebranch = homebranches.branchcode
  JOIN branches holdingbranches ON items.holdingbranch = holdingbranches.branchcode
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'LOC'
  ) permanent_location ON permanent_location.authorised_value = items.permanent_location
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'LOC'
  ) locations ON locations.authorised_value = items.location
  LEFT JOIN itemtypes ON itemtypes.itemtype = items.itype
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'CCODE'
  ) ccodes ON ccodes.authorised_value = items.ccode
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'LOST'
  ) lost ON lost.authorised_value = items.itemlost
  LEFT JOIN reserves ON reserves.itemnumber = items.itemnumber
  LEFT JOIN (
    SELECT branchtransfers.itemnumber,
      'IN_TRANSIT' AS IN_TRANSIT
    FROM branchtransfers
    WHERE branchtransfers.datearrived IS NULL
      AND branchtransfers.datecancelled IS NULL
    GROUP BY branchtransfers.itemnumber
  ) in_transit ON in_transit.itemnumber = items.itemnumber
WHERE 
  items.homebranch != items.holdingbranch
  AND NULLIF(items.itemlost, '') IS NULL
  AND NullIf(items.onloan, '') IS NULL
  AND NullIf(reserves.found, '') IS NULL
  AND Coalesce(in_transit.IN_TRANSIT, '') != 'IN_TRANSIT'
  AND items.homebranch LIKE <<Item home branch|branches:all>>
  AND items.holdingbranch LIKE <<Item current branch|branches:all>>
  AND CASE
    WHEN NullIf(items.permanent_location, '') IS NULL 
    THEN items.location
    WHEN NullIf(items.location, '') IS NULL 
    THEN items.permanent_location
    WHEN items.permanent_location = items.location 
    THEN items.permanent_location
    ELSE Concat_Ws(' ', items.permanent_location, items.location)
  END LIKE Concat('%', <<Shelving location|LOC:all>>, '%')
  AND items.itype LIKE <<Item type|itemtypes:all>>
  AND items.ccode LIKE Concat('%', <<Collection code|CCODE:all>>, '%')
  AND items.datelastseen <= <<Last seen date on or before|date>>
GROUP BY 
  items.itemnumber
ORDER BY 
  HOME_BRANCH,
  LOCATION,
  ITEM_TYPE,
  COLLECTION_CODE,
  call_number_display,
  biblio.author,
  biblio.title

























