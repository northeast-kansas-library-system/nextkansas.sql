/*
R.002785

----------

Name: GHW - Requests troubleshooting 004 - Item check-out history
Created by: George Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-09-29 10:35:34
Modified on: 2024-02-07 16:15:59
Date last run: 2025-07-22 14:58:13

----------

Public: 0
Expiry: 0

----------

 
Identifies circulation history on a specific item
Shows all circulation history that has been completed
on an item you specify
sorted by the last date the item was returned

Notes:

Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, etc.).
Click here to run in a new window


----------
*/



SELECT
  old_issues.returndate,
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  borrowers.cardnumber AS BORROWER,
  old_issues.branchcode AS CHECK_OUT_BRANCH,
  old_issues.issuedate,
  old_issues.date_due,
  old_issues.lastreneweddate
FROM
  old_issues JOIN
  items
    ON old_issues.itemnumber = items.itemnumber JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  borrowers
    ON old_issues.borrowernumber = borrowers.borrowernumber
WHERE
  items.barcode = &lt;&gt;
ORDER BY
  old_issues.returndate DESC

























