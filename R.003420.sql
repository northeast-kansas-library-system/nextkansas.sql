/*
R.003420

----------

Name: GHW - Monthly 112 Monthly statistics master - Borrowers
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2021-02-04 17:10:37
Modified on: 2021-07-29 17:16:31
Date last run: 2021-08-02 15:13:43

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchcode,
  Coalesce(ACCT_USED.count, 0) AS BORROWER_ACCT_USED_LM,
  Coalesce(BORROWERS1.COUNT, 0) AS TOTAL_BORROWERS,
  Coalesce(BORROWERSA.COUNT, 0) AS B_ADDED_LM,
  Coalesce(BORROWERSR.COUNT, 0) AS B_RENEWED_LM,
  Coalesce(BORROWESD.COUNT, 0) AS B_DELETED_LM
FROM
  branches LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(*) AS COUNT
    FROM
      borrowers
    WHERE
      borrowers.dateenrolled < AddDate(Last_Day(SubDate(Now(), INTERVAL 1
      MONTH)), 1)
    GROUP BY
      borrowers.branchcode) BORROWERS1 ON branches.branchcode =
      BORROWERS1.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(*) AS COUNT
    FROM
      borrowers
    WHERE
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) BORROWERSA ON branches.branchcode =
      BORROWERSA.branchcode LEFT JOIN
  (SELECT
      deletedborrowers.branchcode,
      Count(*) AS COUNT
    FROM
      action_logs JOIN
      deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object
    WHERE
      action_logs.module = 'MEMBERS' AND
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      action_logs.action LIKE 'DELET%'
    GROUP BY
      deletedborrowers.branchcode) BORROWESD ON branches.branchcode =
      BORROWESD.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(*) AS COUNT
    FROM
      borrowers
    WHERE
      Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) BORROWERSR ON branches.branchcode =
      BORROWERSR.branchcode LEFT JOIN
  (SELECT
      statistics.branch,
      Count(DISTINCT statistics.borrowernumber) AS count
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
          statistics.type = 'renew' OR
          statistics.type = 'localuse') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch) ACCT_USED ON ACCT_USED.branch = branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



