/*
R.002782

----------

Name: GHW - Requests troubleshooting 001 - Item requests current
Created by: George Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-09-29 09:31:38
Modified on: 2024-01-17 11:36:29
Date last run: 2022-03-28 10:49:55

----------

Public: 0
Expiry: 0

----------

 
Identifies current requests on a specific item (item specific requests)
Shows all current requests
on an item you specify
sorted by the last activity on the item request

Notes:

Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, etc.).
Click here to run in a new window


----------
*/



SELECT
  reserves.timestamp,
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  borrowers.cardnumber AS BORROWER,
  reserves.branchcode AS PICKUP_LOCATION,
  reserves.reservedate,
  reserves.waitingdate,
  reserves.cancellationdate,
  reserves.reservenotes,
  reserves.found
FROM
  items JOIN
  reserves
    ON reserves.itemnumber = items.itemnumber JOIN
  borrowers
    ON reserves.borrowernumber = borrowers.borrowernumber JOIN
  biblio
    ON reserves.biblionumber = biblio.biblionumber
WHERE
  items.barcode = &lt;&gt;
ORDER BY
  reserves.timestamp DESC

























