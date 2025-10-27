/*
R.002799

----------

Name: GHW - Items paid for at a specified home branch
Created by: George Williams

----------

Group: Fines/Fees
     -

Created on: 2016-10-10 09:36:41
Modified on: 2024-01-17 11:36:15
Date last run: 2025-09-03 16:46:53

----------

Public: 0
Expiry: 0

----------

 
Lists items owned by a branch that have been marked as "Paid for" in Koha.
Shows items currently in Koha
at the location (or locations) you specify
grouped and sorted by homebranch, shelving location, item type, collection code, call number, author, and title.

Notes:

Report created at the request of Eudora Public Library.
Click here to run in a new window.


----------
*/



SELECT
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.timestamp
FROM
  items INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber
WHERE
  items.homebranch LIKE &lt;&gt; AND
  items.paidfor IS NOT NULL AND
  items.paidfor &lt;&gt; " "
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title

























