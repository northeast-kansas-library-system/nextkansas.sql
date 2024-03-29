/*
R.002713

----------

Name: GHW - All items added after a specified date
Created by: George H Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2016-07-21 15:13:21
Modified on: 2017-12-19 09:32:57
Date last run: 2022-12-14 11:39:23

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>This report shows all items added to NExpress at a specific library branch after a specified date</p>
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
  CONCAT( '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber,'\" target="_blank">', biblio.biblionumber, '</a>' ) AS LINK_TO_TITLE,
  items.itemnumber,
  items.homebranch,
  items.barcode,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  items.enumchron,
  biblio.author,
  CONCAT_WS(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]') ) AS FULL_TITLE,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen,
  IF(items.onloan IS NULL,' ','Checked out') AS CHECKED_OUT,
  IF(SUM(items.damaged + items.itemlost + items.withdrawn)=0,' ','Damaged, lost, or withdrawn') AS STATUS_PROBLEMS
FROM
  items JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber INNER JOIN
  biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber AND
    items.biblionumber = biblio_metadata.biblionumber
WHERE
  items.homebranch LIKE <<Item home library|LBRANCH>> AND
  items.location LIKE <<Item shelving location|LLOC>> AND
  items.itype LIKE <<Item type|LITYPES>> AND
  items.ccode LIKE <<Item collection code|LCCODE>> AND
  items.dateaccessioned > <<Look for all items added after|date>>
GROUP BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  items.enumchron,
  biblio.author,
  biblio.title

























