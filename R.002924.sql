/*
R.002924

----------

Name: GHW - BONNERSPGS price repair
Created by: George Williams

----------

Group:  BONNERSPGS
     -

Created on: 2017-03-17 16:59:13
Modified on: 2024-01-17 11:49:27
Date last run: 2019-12-26 17:27:38

----------

Public: 0
Expiry: 0

----------

 
Report for Bonner Springs to help add discounted costs of items to records
Shows items added in the date range you specify
Shows items owned by Bonner Springs with a value in the 952g field of less than $0.01
Allows the user to specify shelving location, collection code, item type, and source of acquisition
sorted by standard NExpress classification scheme
links to the "Edit item" page for each item

Notes:

The sources of acquisition in the database appear to be “AMAZON,” “AUTHOR,” “CENTER POINT,” “CHILDREN'S PLUS,” “Donation,” “GALE,” “INGRAM,” “INGRAMS,” “MIDWEST TAPE,” “MIDWEST TAPES,” “NEW READERS PRESS,” “OMNIGRAPHICS,” "PUBLISHER DIRECT," "RECATALOG," “RECORDED BOOKS,” and “TURN THE PAGE KC.”  If staff want to limit to one source, they can enter the exact name of the source in the "Source of acquisition" field in this report, or, since Ingram appears to be spelled two different ways, staff can type "Ing%" to get all items from Ingram - even if "Ingram" is misspelled in the item record.

Click here to run in a new window


----------
*/



SELECT
  Concat('', biblio.biblionumber, '') AS
  LINK_TO_ITEM,
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  items.dateaccessioned,
  Coalesce(items.booksellerid, "-") AS SOURCE,
  Coalesce(items.price, 0) AS PRICE,
  items.price,
  items.replacementprice
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
WHERE
  items.dateaccessioned BETWEEN &lt;&gt; AND &lt;&gt; AND
  items.homebranch = "BONNERSPGS" AND
  items.location LIKE &lt;&gt; AND
  items.itype LIKE &lt;&gt; AND
  items.ccode LIKE &lt;&gt; AND
  Coalesce(items.booksellerid, "-") LIKE Concat("%", &lt;&gt;, "%") AND
  Coalesce(items.price, 0) &lt; .01
GROUP BY
  items.barcode
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title
LIMIT 10000

























