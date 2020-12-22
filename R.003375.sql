/*
R.003375

----------

Name: koha-us Demo 4
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 09:33:05
Modified on: 2020-11-23 09:33:05
Date last run: 2020-11-23 11:24:02

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  statistics.branch,
  Count(statistics.datetime) AS CKO_PLUS_RENEW
FROM
  statistics
WHERE
  (statistics.type = 'issue' OR
      statistics.type = 'renew') AND
  Month(statistics.datetime) = 10 AND
  Year(statistics.datetime) = 2020
GROUP BY
  statistics.branch



