/*
R.002783

----------

Name: GHW - Requests troubleshooting 002 - Item request history
Created by: George H Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-09-29 09:54:40
Modified on: 2018-04-16 11:02:28
Date last run: 2019-11-08 20:52:20

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Identifies old requests on a specific item</p>
<ul><li>Shows all finished requests</li>
<li>on an item you specify</li>
<li>sorted by the last activity on the item request</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, etc.).</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2783&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  old_reserves.timestamp,
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  borrowers.cardnumber AS BORROWER,
  old_reserves.branchcode AS PICKUP_LOCATION,
  old_reserves.reservedate,
  old_reserves.waitingdate,
  old_reserves.cancellationdate,
  old_reserves.reservenotes,
  old_reserves.found
FROM
  items JOIN
  old_reserves
    ON old_reserves.itemnumber = items.itemnumber JOIN
  borrowers
    ON old_reserves.borrowernumber = borrowers.borrowernumber JOIN
  biblio
    ON old_reserves.biblionumber = biblio.biblionumber
WHERE
  items.barcode = <<Enter item barcode number>>
ORDER BY
  old_reserves.timestamp DESC



