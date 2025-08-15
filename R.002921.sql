/*
R.002921

----------

Name: GHW - Count of checkins during a specified date range
Created by: George Williams

----------

Group: Circulation
     Circ Stats

Created on: 2017-03-08 08:40:06
Modified on: 2024-01-17 11:49:23
Date last run: 2024-08-27 14:16:41

----------

Public: 0
Expiry: 0

----------

 
Counts the number of items returned at a specified branch during a specified date range (and can be limited to specified days of the week)
Counts returns during the date range you specify (the statistics table only covers the previous 25 months)
Counts returns at the library you specify
grouped and sorted by the branch where the items were checked in and the date the items were returned

Notes:

Click here to run in a new window


----------
*/



SELECT
  statistics.branch AS CHECK_IN_BRANCH,
  CAST(statistics.datetime AS DATE) AS DATE,
  Date_Format(statistics.datetime, '%a') AS DAY,
  COUNT(*) AS RETURN_COUNT
FROM
  statistics
WHERE
  statistics.type = 'return' AND
  statistics.branch LIKE &lt;&gt; AND
  (CAST(statistics.datetime AS DATE) BETWEEN &lt;&gt; AND &lt;&gt;) AND
  Date_Format(statistics.datetime, '%a') LIKE &lt;&gt;
GROUP BY
  CHECK_IN_BRANCH,
  DATE

























