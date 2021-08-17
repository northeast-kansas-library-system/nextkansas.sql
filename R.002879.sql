/*
R.002879

----------

Name: GHW - Tonganoxie 200th patron report
Created by: George H Williams

----------

Group:  TONGANOXIE
     -

Created on: 2017-01-06 12:02:25
Modified on: 2021-08-16 13:40:06
Date last run: 2018-05-04 17:45:55

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows an index of patrons with a TONGANOXIE home library during the 2017 calendar year</p>
<ul><li>Shows patrons added during 2017</li>
<li>With a Tonganoxie home branch</li>
<li>grouped by borrowers.cardnumber, borrowers.dateenrolled, borrowers.borrowernumber</li>
<li>sorted by patron index number</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2879&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  borrowers.cardnumber,
  borrowers.dateenrolled,
  @curRow := @curRow + 1 AS PATRON_NUMBER
FROM
  borrowers CROSS JOIN
  (SELECT
    @curRow := 0) r
WHERE
  borrowers.branchcode = 'Tonganoxie' AND
  Year(borrowers.dateenrolled) = 2017
GROUP BY
  borrowers.cardnumber, borrowers.dateenrolled, borrowers.borrowernumber
ORDER BY
  PATRON_NUMBER DESC



