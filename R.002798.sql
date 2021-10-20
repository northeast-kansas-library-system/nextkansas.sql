/*
R.002798

----------

Name: GHW - Stats Sample 001
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-10-10 09:04:14
Modified on: 2016-10-10 09:09:25
Date last run: -

----------

Public: 0
Expiry: 0

----------

Report created for "Flexible reports" demo.

----------
*/



SELECT
  statistics.branch,
  statistics.itemtype,
  count(*)
FROM statistics
WHERE statistics.type = "issue" AND
  (statistics.datetime BETWEEN "2016-09-01" AND "2016-09-08")
GROUP BY statistics.branch, statistics.itemtype
WITH ROLLUP

























