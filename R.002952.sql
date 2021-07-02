/*
R.002952

----------

Name: GHW - Monthly statistics 001
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2017-06-05 14:15:13
Modified on: 2017-06-05 14:41:01
Date last run: 2021-06-10 17:52:20

----------

Public: 0
Expiry: 300

----------

Checkouts and renewals

----------
*/

SELECT
  branches.branchcode,
  Coalesce(CIR_RENEW_LM.count, 0) AS CHECKOUT_RENEW_LM
FROM
  branches
  LEFT JOIN (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch) CIR_RENEW_LM ON branches.branchcode = CIR_RENEW_LM.branch
WHERE
  branches.branchcode LIKE <<Choose library|LBRANCH>>
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



