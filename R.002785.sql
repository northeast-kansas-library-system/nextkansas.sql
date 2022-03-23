/*
R.002785

----------

Name: GHW - Requests troubleshooting 004 - Item check-out history
Created by: George H Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-09-29 10:35:34
Modified on: 2018-04-16 11:02:24
Date last run: 2022-01-24 10:03:51

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Identifies circulation history on a specific item</p>
<ul><li>Shows all circulation history that has been completed</li>
<li>on an item you specify</li>
<li>sorted by the last date the item was returned</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, etc.).</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2785&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
  old_issues.renewals,
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
  items.barcode = <<Enter item barcode number>>
ORDER BY
  old_issues.returndate DESC

























