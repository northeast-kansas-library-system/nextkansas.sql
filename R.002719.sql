/*
R.002719

----------

Name: GHW - Reports Template B
Created by: George Williams

----------

Group: -
     -

Created on: 2016-08-03 17:09:26
Modified on: 2023-10-16 22:05:21
Date last run: -

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
  items.ccode LIKE &lt;&gt;
GROUP BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  items.enumchron,
  biblio.author,
  biblio.title

























