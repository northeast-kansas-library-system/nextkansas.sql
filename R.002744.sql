/*
R.002744

----------

Name: GHW - Paola Carousel Number report
Created by: George Williams

----------

Group: -
     -

Created on: 2016-08-29 13:00:26
Modified on: 2024-01-17 11:36:50
Date last run: 2024-09-05 08:48:46

----------

Public: 0
Expiry: 0

----------

 
This report shows all items added to NExpress at a specific library branch after a specified date - includes date added, date last borrowed, date last seen, and total circulations+renewals
Shows items that are currently still in NExpress
Allows user to specify the item's homebranch, shelving location, item type, collection code, and the item's date added
grouped by homebranch, location, itype, collection code, and call number
sorted by homebranch, location, itype, collection code, and call number
contains links directly to the item's bibliographic record



----------
*/



SELECT
  Coalesce(items.copynumber, "~") AS copynumber,
  Concat('', biblio.biblionumber, '') AS LINK_TO_TITLE,
  items.itemnumber,
  items.homebranch,
  items.barcode,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen,
  items.issues,
  items.renewals,
  If(items.onloan IS NULL, ' ', 'Currently checked out') AS CHECKED_OUT,
  If(Sum(items.damaged + items.itemlost + items.withdrawn) = 0, ' ', 'Damaged, lost, or withdrawn') AS STATUS_PROBLEMS
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  (items.homebranch = 'PAOLA' AND
  Coalesce(items.copynumber, "~") &lt;&gt; "~") OR
  (items.homebranch = 'PAOLA' AND
  Coalesce(items.copynumber, "~") = "~" AND
  (items.itype LIKE 'NVID%') AND
  items.itemcallnumber LIKE "%MOV%")
GROUP BY
  items.itemnumber
ORDER BY
  copynumber,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE

























