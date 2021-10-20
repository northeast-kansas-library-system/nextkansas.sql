/*
R.002962

----------

Name: GHW - Returns by date range
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-06-26 17:37:39
Modified on: 2017-06-26 17:37:39
Date last run: 2020-08-17 09:18:55

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches.branchcode,
  Coalesce(circulation.RETURNS, 0) AS CKO_PLUS_RENEW
FROM
  branches
  LEFT JOIN (SELECT
      statistics.branch,
      COUNT(*) AS RETURNS
    FROM
      statistics
    WHERE
      (statistics.type = 'return') AND
      statistics.datetime BETWEEN <<Between the beginning of the day on|date>> AND <<the end of the day on|date>> + INTERVAL 1 DAY
    GROUP BY
      statistics.branch) circulation ON branches.branchcode = circulation.branch
WHERE
  branches.branchcode LIKE <<Select checkout branch|LBRANCH>>
GROUP BY
  branches.branchcode,
  Coalesce(circulation.RETURNS, 0)

























