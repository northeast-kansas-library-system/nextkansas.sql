/*
R.002961

----------

Name: GHW - Checkouts + Renewals by date range
Created by: George H Williams

----------

Group: Statistics
     -

Created on: 2017-06-26 17:18:03
Modified on: 2017-06-26 17:27:23
Date last run: 2020-12-17 10:34:25

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchcode,
  Coalesce(circulation.CKO_PLUS_RENEW, 0) AS CKO_PLUS_RENEW
FROM
  branches
  LEFT JOIN (SELECT
      statistics.branch,
      COUNT(*) AS CKO_PLUS_RENEW
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      statistics.datetime BETWEEN <<Between the beginning of the day on|date>> AND <<the end of the day on|date>> + INTERVAL 1 DAY
    GROUP BY
      statistics.branch) circulation ON branches.branchcode = circulation.branch
WHERE
  branches.branchcode LIKE <<Select checkout branch|LBRANCH>>
GROUP BY
  branches.branchcode,
  Coalesce(circulation.CKO_PLUS_RENEW, 0)



