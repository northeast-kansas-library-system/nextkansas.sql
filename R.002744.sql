/*
R.002744

----------

Name: GHW - Paola Carousel Number report
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-08-29 13:00:26
Modified on: 2020-02-27 10:40:35
Date last run: 2023-05-16 15:57:01

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>This report shows all items added to NExpress at a specific library branch after a specified date - includes date added, date last borrowed, date last seen, and total circulations+renewals</p>
<ul><li>Shows items that are currently still in NExpress</li>
<li>Allows user to specify the item's homebranch, shelving location, item type, collection code, and the item's date added</li>
<li>grouped by homebranch, location, itype, collection code, and call number</li>
<li>sorted by homebranch, location, itype, collection code, and call number</li>
<li>contains links directly to the item's bibliographic record</li>
</ul><br />
</div>

----------
*/



SELECT
  Coalesce(items.copynumber, "~") AS copynumber,
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">', biblio.biblionumber, '</a>') AS LINK_TO_TITLE,
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
  Coalesce(items.copynumber, "~") <> "~") OR
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

























