/*
R.002987

----------

Name: Koha US Sample 07
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-08-07 19:49:20
Modified on: 2017-08-07 19:49:20
Date last run: 2017-12-18 22:13:26

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchcode,
  Coalesce(stats.CIRC_PLUS_RENEW, 0) AS CIRC_PLUS_RENEWAL
FROM
  branches
  LEFT JOIN (SELECT
      statistics.branch,
      Coalesce(count(*), 0) AS CIRC_PLUS_RENEW
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      statistics.datetime BETWEEN "2017-07-01" AND "2017-08-01"
    GROUP BY
      statistics.branch) stats ON branches.branchcode = stats.branch
WHERE
  branches.branchcode LIKE <<Choose your library|LBRANCH>>
GROUP BY
  branches.branchcode



