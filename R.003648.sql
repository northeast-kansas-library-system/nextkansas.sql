/*
R.003648

----------

Name: Test
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-02-07 09:12:49
Modified on: 2022-02-07 09:12:49
Date last run: 2022-02-15 21:54:34

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowernumber
FROM
  statistics
WHERE
  YEAR(statistics.datetime) = 2022 AND
  MONTH(statistics.datetime) = 1 AND
  DAY(statistics.datetime) = 5
GROUP BY
  borrowernumber

























