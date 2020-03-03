/*
R.002782

----------

Name: GHW - Requests troubleshooting 001 - Item requests current
Created by: George H Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-09-29 09:31:38
Modified on: 2018-04-16 11:02:31
Date last run: 2019-11-08 20:52:14

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Identifies current requests on a specific item (item specific requests)</p>
<ul><li>Shows all current requests</li>
<li>on an item you specify</li>
<li>sorted by the last activity on the item request</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, etc.).</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2782&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
  items.barcode = <<Enter item barcode number>>
ORDER BY
  reserves.timestamp DESC



