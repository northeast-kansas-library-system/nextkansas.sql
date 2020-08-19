/*
R.002839

----------

Name: GHW 997-Circulation by hour
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-11-28 11:24:32
Modified on: 2016-11-28 12:18:38
Date last run: 2020-06-16 15:33:34

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  statistics.branch AS CHECK_OUT_BRANCH,
  Year(statistics.datetime) AS YEAR,
  Month(statistics.datetime) AS MONTH,
  Day(statistics.datetime) AS DAY,
  Dayname(statistics.datetime) AS DAYNAME,
  Hour(statistics.datetime) AS HOUR,
  Count(*) AS CIRC_PLUS_RENEWALS
FROM
  statistics
WHERE
  (statistics.datetime BETWEEN  <<Start date|date>>  AND (<<End date|date>>+ INTERVAL 1 DAY)) AND
  (statistics.type = 'issue' OR statistics.type = 'renew' OR statistics.type = 'localuse') AND
  statistics.branch LIKE <<Check out branch|LBRANCH>>
GROUP BY
  CHECK_OUT_BRANCH,
  YEAR,
  MONTH,
  DAY,
  HOUR



