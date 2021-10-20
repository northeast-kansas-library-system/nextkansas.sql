/*
R.002801

----------

Name: GHW - Requests troubleshooting 005 - Patron requests history
Created by: George H Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-10-11 09:41:49
Modified on: 2018-04-16 11:02:17
Date last run: 2019-08-21 16:55:11

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Identifies past requests made by a specific patron</p>
<ul><li>Shows request history</li>
<li>on a patron you specify</li>
<li>sorted by the last activity on the request</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, patron received e-mail but we can't find the request, etc.).</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2801&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  old_reserves.reserve_id,
  old_reserves.biblionumber,
  old_reserves.timestamp,
  biblio.author,
  biblio.title,
  borrowers.cardnumber,
  old_reserves.branchcode,
  old_reserves.reservedate,
  old_reserves.waitingdate,
  old_reserves.cancellationdate,
  old_reserves.reservenotes,
  old_reserves.found
FROM
  old_reserves INNER JOIN
  borrowers
    ON old_reserves.borrowernumber = borrowers.borrowernumber INNER JOIN
  biblio
    ON old_reserves.biblionumber = biblio.biblionumber
WHERE
  borrowers.cardnumber = <<Enter patron barcode number>>
ORDER BY
  old_reserves.timestamp
DESC

























