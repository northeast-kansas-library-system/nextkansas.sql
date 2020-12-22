/*
R.003374

----------

Name: koha-US demo 3
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 09:32:00
Modified on: 2020-11-23 09:32:00
Date last run: 2020-11-23 11:23:37

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
  statistics.datetime BETWEEN <<Date 1|date>> AND <<Date 2|date>> AND
  (statistics.type = 'issue' OR
      statistics.type = 'renew')
GROUP BY
  statistics.branch



