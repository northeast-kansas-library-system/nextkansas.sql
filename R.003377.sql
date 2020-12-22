/*
R.003377

----------

Name: koha-us Demo 6
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 09:34:01
Modified on: 2020-11-23 09:34:01
Date last run: 2020-11-23 11:31:22

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
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
GROUP BY
  statistics.branch



