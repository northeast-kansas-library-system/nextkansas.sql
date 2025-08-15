/*
R.002962

----------

Name: GHW - Returns by date range
Created by: George Williams

----------

Group: -
     -

Created on: 2017-06-26 17:37:39
Modified on: 2017-06-26 17:37:39
Date last run: 2025-04-21 18:31:11

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
      statistics.datetime BETWEEN &lt;&gt; AND &lt;&gt; + INTERVAL 1 DAY
    GROUP BY
      statistics.branch) circulation ON branches.branchcode = circulation.branch
WHERE
  branches.branchcode LIKE &lt;&gt;
GROUP BY
  branches.branchcode,
  Coalesce(circulation.RETURNS, 0)

























