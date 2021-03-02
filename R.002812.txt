/*
R.002812

----------

Name: GHW - TEsting again
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-10-27 15:49:07
Modified on: 2016-10-27 15:50:32
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  Count(*) AS Count
FROM
  statistics
WHERE
  (statistics.datetime BETWEEN <<between the beginning of the day on "START DATE"|date>>  AND (<<and the end of the day on "END DATE"|date>>+ INTERVAL 1 DAY)) AND
  statistics.type IN ("issue", "renew")



