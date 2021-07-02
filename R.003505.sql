/*
R.003505

----------

Name: GHW - Circulation last month by zipcode
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-05-12 20:58:05
Modified on: 2021-05-12 20:58:05
Date last run: 2021-07-01 01:00:03

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Counts checkouts and renewals by check-out library and zipcode</p>
<ul><li>during the previous calendar month</li>
<li>at all system libraries</li>
<li>grouped and sorted by checkout-library and borrower zipcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports= XX PUT REPORTNUMBER HERE and remove XXs and Spaces XX &phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">tag goes here</p>
</div>

----------
*/

SELECT
  statistics.branch AS CKO_BRANCH,
  Left(borrowers.zipcode, 5) AS BORROWER_ZIPCODE,
  COUNT(*) AS CKO_RENEW
FROM
  statistics LEFT JOIN
  borrowers ON borrowers.borrowernumber = statistics.borrowernumber
WHERE
  (statistics.type = 'issue' OR
      statistics.type = 'renew') AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
GROUP BY
  statistics.branch,
  Left(borrowers.zipcode, 5)
ORDER BY
  CKO_BRANCH,
  BORROWER_ZIPCODE



