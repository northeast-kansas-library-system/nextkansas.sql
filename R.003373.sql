/*
R.003373

----------

Name: koha-US demo 2
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 09:31:28
Modified on: 2020-11-23 09:31:28
Date last run: 2020-11-23 11:21:52

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
  statistics.datetime BETWEEN <<Date 1>> AND <<Date 2>> AND
  (statistics.type = 'issue' OR
      statistics.type = 'renew')
GROUP BY
  statistics.branch



