/*
R.002792

----------

Name: GHW - Stats Sample 002
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2016-10-07 23:22:38
Modified on: 2016-10-09 19:58:47
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  statistics.branch,
  statistics.itemtype,
  count(*)
FROM statistics
WHERE statistics.type = "issue" AND
  (statistics.datetime BETWEEN "2016-09-01" AND "2016-09-08") AND
  statistics.branch LIKE <<Enter branch code>>
GROUP BY statistics.branch, statistics.itemtype
WITH ROLLUP



