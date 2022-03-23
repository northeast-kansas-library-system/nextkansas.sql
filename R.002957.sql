/*
R.002957

----------

Name: GHW - Monthly statistics 006
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2017-06-05 14:44:17
Modified on: 2017-06-05 14:44:17
Date last run: 2022-02-09 14:49:50

----------

Public: 0
Expiry: 300

----------

Patron cards used to check out items last month

----------
*/



SELECT
  branches.branchcode,
  Coalesce(ACCT_USED.count, 0) AS PATRON_LM
FROM
  branches
  LEFT JOIN (SELECT
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
      statistics.branch) ACCT_USED ON branches.branchcode = ACCT_USED.branch
WHERE
  branches.branchcode LIKE <<Choose library|LBRANCH>>
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode

























