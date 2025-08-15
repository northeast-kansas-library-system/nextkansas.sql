/*
R.002802

----------

Name: GHW - Requests troubleshooting 006 - Patron requests current
Created by: George Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-10-11 09:45:12
Modified on: 2024-01-17 11:36:11
Date last run: 2019-08-21 16:03:37

----------

Public: 0
Expiry: 0

----------

 
Identifies current requests on a specific item (item specific requests)
Shows current requests for a specified patron
on a patron you specify
sorted by the last activity on the request

Notes:

Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, patron received e-mail but we can't find the request, etc.).
Click here to run in a new window


----------
*/



SELECT
  reserves.timestamp,
  reserves.biblionumber,
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
  borrowers.cardnumber = &lt;&gt;
ORDER BY
  reserves.timestamp DESC

























