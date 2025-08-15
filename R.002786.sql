/*
R.002786

----------

Name: GHW - Flexible New Items Report
Created by: George Williams

----------

Group: -
     -

Created on: 2016-10-05 14:39:48
Modified on: 2024-01-17 11:36:21
Date last run: 2025-08-14 15:12:12

----------

Public: 0
Expiry: 0

----------

 
This report shows all items added to Next Search Catalog at a specific library branch during a date range
Shows items that are currently still in Next Search Catalog
Allows user to specify the item's homebranch, shelving location, item type, collection code, and the item's date added
grouped by biblionumber and itemnumber
sorted by homebranch, location, itype, collection code, call number, author, title
contains links directly to the item's bibliographic record in the OPAC



----------
*/



SELECT
  Concat(
    'Go to OPAC'
  ) AS LINK_TO_OPAC,
  items.biblionumber,
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  LOCATIONSP.lib AS PERM_LOCATION,
  LOCATIONS.lib AS LOCATION,
  ITYPES.description AS ITEM_TYPE,
  CCODES.lib AS COLLECTION,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  items.dateaccessioned,
  If(items.onloan IS NULL, ' ', 'Currently checked out') AS CHECKED_OUT,
  If(Sum(items.damaged + items.itemlost + items.withdrawn) = 0, ' ', 'Damaged, lost, or withdrawn') AS STATUS_PROBLEMS
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber AND
      items.biblionumber = biblio_metadata.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') LOCATIONSP ON
      LOCATIONSP.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') LOCATIONS ON
      LOCATIONS.authorised_value = items.location LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) ITYPES ON ITYPES.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') CCODES ON CCODES.authorised_value = items.ccode
WHERE
  items.homebranch LIKE &lt;&gt; AND
  items.location LIKE &lt;&gt; AND
  items.itype LIKE &lt;&gt; AND
  items.ccode LIKE &lt;&gt; AND
  items.dateaccessioned BETWEEN &lt;&gt; AND &lt;&gt;
GROUP BY
  items.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  PERM_LOCATION,
  ITEM_TYPE,
  COLLECTION,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE

























