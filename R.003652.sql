/*
R.003652

----------

Name: GHW - Suppressed bibliographic records 
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-02-28 17:45:23
Modified on: 2022-02-28 17:45:45
Date last run: 2022-02-28 17:46:13

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    '<a class="btn btn-default" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    items.biblionumber, 
    '\" target="_blank">Go to title</a>'
  ) AS LINK_TO_TITLE,
  biblio.biblionumber,
  homebranch.branchname AS HOME,
  holdingbranch.branchname AS HOLDING,
  perm_locs.lib AS PERM_LOCATION,
  locs.lib AS LOCATION,
  itemtypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  Concat_Ws('', 
    items.itemcallnumber, 
    Concat(' / Copy #: ', items.copynumber)
  ) AS CALL_NUMBER,
  biblio.author,
  Concat_Ws(' ', 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]')
  ) AS TITLE,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="n"]') AS SUPPRESSED
FROM
  biblio JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN
  items ON items.biblionumber = biblio.biblionumber INNER JOIN
  branches homebranch ON homebranch.branchcode = items.homebranch INNER JOIN
  branches holdingbranch ON holdingbranch.branchcode = items.holdingbranch
  LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc') perm_locs ON
      perm_locs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc') locs ON locs.authorised_value =
      items.location LEFT JOIN
  itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="n"]') = 1 AND
  items.homebranch LIKE <<Choose your library|ZBRAN>>
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  HOME,
  PERM_LOCATION,
  ITYPE,
  CCODE,
  CALL_NUMBER,
  biblio.author,
  TITLE

























