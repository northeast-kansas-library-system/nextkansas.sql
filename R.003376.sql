/*
R.003376

----------

Name: koha-us Demo 5
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 09:33:37
Modified on: 2020-11-23 09:33:37
Date last run: 2020-11-23 11:25:36

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
  Month(statistics.datetime) = <<Enter month>> AND
  Year(statistics.datetime) = <<Enter year>>
GROUP BY
  statistics.branch



