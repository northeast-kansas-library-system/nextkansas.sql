/*
R.001681

----------

Name: Count of Holds Filled each month
Created by: Heather Braum

----------

Group: Holds-Reserves
     Holds Statistics

Created on: 2012-12-18 21:23:39
Modified on: 2013-06-23 12:32:43
Date last run: 2019-09-16 12:32:24

----------

Public: 0
Expiry: 0

----------

#holds Choose branch. 

----------
*/

SELECT MONTH(timestamp), YEAR(timestamp), count(*) FROM old_reserves WHERE old_reserves.branchcode = <<Pick your Branch|branches>> GROUP BY MONTH(timestamp), YEAR(timestamp) ORDER BY YEAR(timestamp) DESC, MONTH(timestamp) DESC



