/*
R.002833

----------

Name: GHW - 001 Monthly circulation
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-11-28 08:38:18
Modified on: 2016-11-28 12:21:10
Date last run: 2022-06-07 16:30:17

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  statistics.branch,
  Count(*) AS CIRC_PLUS_RENEWALS,
  Concat_Ws('.', Year(statistics.datetime), Month(statistics.datetime)) AS DATE
FROM
  statistics
WHERE
  (statistics.type = 'issue' OR statistics.type = 'renew' OR statistics.type = 'localuse') AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
GROUP BY
  statistics.branch
  WITH ROLLUP

























