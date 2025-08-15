/*
R.003906

----------

Name: TEST
Created by: George Williams

----------

Group: -
     -

Created on: 2025-08-06 15:27:41
Modified on: 2025-08-06 15:45:40
Date last run: 2025-08-06 15:45:42

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  statistics.branch,
  Date_Format(statistics.datetime, '%m-%d') AS DATE,
  Count(*) AS Count_Column1
FROM
  statistics
WHERE
  statistics.datetime BETWEEN Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) AND Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY) AND
  (statistics.type = 'issue' OR
    statistics.type = 'renew') AND 
  statistics.branch = &lt;&gt;
GROUP BY
  statistics.branch,
  Date_Format(statistics.datetime, '%m-%d')
ORDER BY
  statistics.branch,
  DATE

























