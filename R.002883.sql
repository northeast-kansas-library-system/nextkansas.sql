/*
R.002883

----------

Name: GHW - Deleted item information
Created by: George Williams

----------

Group: Catalog Records and Items
     -

Created on: 2017-01-10 16:12:46
Modified on: 2024-01-17 11:48:47
Date last run: 2025-03-28 15:27:59

----------

Public: 0
Expiry: 0

----------

 
Lists information about deleted items
Shows information on items that have data in the deleteditems table
Shows information for the single barcode number you specify
grouped by item barcode
If there is still an active bibliographic record for the title, a link will appear to that record

Click here to run in a new window


----------
*/



SELECT
  If(Coalesce(biblio.biblionumber, 0) = deleteditems.biblionumber, Concat('Click for bibliographic record'), If(Coalesce(deletedbiblio.biblionumber, 0) &gt; 0, 'Biblio has been deleted', '--') ) AS BIBLIO_RECORD_STATUS,
  deleteditems.barcode,
  deleteditems.homebranch,
  deleteditems.location,
  deleteditems.itype,
  deleteditems.ccode,
  deleteditems.itemcallnumber,
  If(Coalesce(deletedbiblio.author, '--') = '--', Coalesce(biblio.author, '--'), Coalesce(deletedbiblio.author, '--')) AS AUTHOR,
  If(Coalesce(deletedbiblio.title, '--') = '--', Coalesce(biblio.title, '--'), Coalesce(deletedbiblio.title, '--')) AS TITLE,
  deleteditems.replacementprice,
  deleteditems.timestamp AS DELETED_ON
FROM
  deleteditems LEFT JOIN
  biblio
    ON deleteditems.biblionumber = biblio.biblionumber LEFT JOIN
  deletedbiblio
    ON deleteditems.biblionumber = deletedbiblio.biblionumber
WHERE
  deleteditems.barcode LIKE Concat("%", &lt;&gt;, "%")
GROUP BY
  deleteditems.biblionumber
ORDER BY
  deleteditems.homebranch,
  deleteditems.location,
  deleteditems.itype,
  deleteditems.ccode,
  deleteditems.itemcallnumber,
  AUTHOR,
  TITLE

























