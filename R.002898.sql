/*
R.002898

----------

Name: GHW - Monthly 103 - Borrowers
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2017-02-01 19:48:17
Modified on: 2019-07-01 16:06:36
Date last run: 2022-03-01 10:14:02

----------

Public: 0
Expiry: 300

----------

<p style="display: none;">MNTHLY</p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=2898">Click here to download as a csv file</a></p>

----------
*/



SELECT
  branches.branchcode,
  Coalesce(BORROWERS1.COUNT, 0) AS TOTAL_BORROWERS,
  Coalesce(BORROWERSA.COUNT, 0) AS B_ADDED_LM,
  Coalesce(BORROWERSR.COUNT, 0) AS B_RENEWED_LM,
  Coalesce(BORROWESD.COUNT, 0) AS B_DELETED_LM
FROM
  branches
  LEFT JOIN (SELECT
        borrowers.branchcode,
        Count(*) AS COUNT
      FROM
        borrowers
      WHERE
        borrowers.dateenrolled < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
      GROUP BY
        borrowers.branchcode) BORROWERS1 ON branches.branchcode = BORROWERS1.branchcode
  LEFT JOIN (SELECT
        borrowers.branchcode,
        Count(*) AS COUNT
      FROM
        borrowers
      WHERE
        Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        borrowers.branchcode) BORROWERSA ON branches.branchcode = BORROWERSA.branchcode
  LEFT JOIN (SELECT
        deletedborrowers.branchcode,
        Count(*) AS COUNT
      FROM
        action_logs
        JOIN deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object
      WHERE
        action_logs.module = 'MEMBERS' AND
        Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
        action_logs.action LIKE 'DELET%'
      GROUP BY
        deletedborrowers.branchcode) BORROWESD ON branches.branchcode = BORROWESD.branchcode
  LEFT JOIN (SELECT
        borrowers.branchcode,
        Count(*) AS COUNT
      FROM
        borrowers
      WHERE
        Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        borrowers.branchcode) BORROWERSR ON branches.branchcode = BORROWERSR.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode

























