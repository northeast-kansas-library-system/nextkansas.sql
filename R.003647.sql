/*
R.003647

----------

Name: Test
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-02-07 08:57:23
Modified on: 2022-02-07 08:57:23
Date last run: 2022-02-07 08:58:28

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

























