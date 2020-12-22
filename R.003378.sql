/*
R.003378

----------

Name: koha-us Demo 7
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 09:34:30
Modified on: 2020-11-23 09:41:57
Date last run: 2020-11-23 11:32:17

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchname,
  Count(statistics.datetime) AS CKO_PLUS_RENEW
FROM
  statistics JOIN
  branches ON statistics.branch = branches.branchcode
WHERE
  (statistics.type = 'issue' OR
      statistics.type = 'renew') AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
GROUP BY
  branches.branchname



