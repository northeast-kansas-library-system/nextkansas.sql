/*
R.003372

----------

Name: koha-US demo 1
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-16 10:45:42
Modified on: 2020-11-23 09:30:26
Date last run: 2020-11-23 11:16:52

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
  statistics.datetime BETWEEN "2020-10-01" AND "2020-11-01" AND
  (statistics.type = 'issue' OR
      statistics.type = 'renew')
GROUP BY
  statistics.branch



