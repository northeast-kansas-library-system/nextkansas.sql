/*
R.002794

----------

Name: GHW - Stats Sample 004
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2016-10-07 23:24:22
Modified on: 2016-10-09 20:06:45
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
  statistics.branch LIKE <<Enter branch code|LBRANCH>>
GROUP BY statistics.branch, statistics.itemtype
WITH ROLLUP

























