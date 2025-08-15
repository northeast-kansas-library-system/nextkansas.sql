/*
R.002713

----------

Name: GHW - All items added after a specified date
Created by: George Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2016-07-21 15:13:21
Modified on: 2023-10-16 22:05:37
Date last run: 2025-08-12 10:30:08

----------

Public: 0
Expiry: 0

----------

 
This report shows all items added to NExpress at a specific library branch after a specified date
Shows items that are currently still in NExpress
Allows user to specify the item's homebranch, shelving location, item type, collection code, and the item's date added
grouped by homebranch, location, itype, collection code, and call number
sorted by homebranch, location, itype, collection code, and call number
contains links directly to the item's bibliographic record



----------
*/



SELECT
  CONCAT( '', biblio.biblionumber, '' ) AS LINK_TO_TITLE,
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
  items.homebranch LIKE &lt;&gt; AND
  items.location LIKE &lt;&gt; AND
  items.itype LIKE &lt;&gt; AND
  items.ccode LIKE &lt;&gt; AND
  items.dateaccessioned &gt; &lt;&gt;
GROUP BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  items.enumchron,
  biblio.author,
  biblio.title

























