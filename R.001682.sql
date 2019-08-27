/*
R.001682

----------

Name: Count of holds placed by month & year
Created by: Heather Braum

----------

Group: Holds-Reserves
     Holds Statistics

Created on: 2012-12-18 21:28:12
Modified on: 2017-07-10 17:30:41
Date last run: 2017-07-10 17:31:02

----------

Public: 0
Expiry: 0

----------

choose your branch twice #holds #count #size

<p>Note added by GHW on 2017.07.10</p>
<p>&nbsp;</p>
<p>This report was written in 2012.  In 2014 NExpress asked ByWater to start pruning data from the database on a regular basis in an effort to speed up the software.  The practical upshot of that effort for this report is that the data is only accurate for the previous 180 days.</p>


----------
*/

SELECT month, year, sum(count) AS holds
FROM (
SELECT MONTH(reservedate) AS month, YEAR(reservedate) AS Year, count(*) AS count
FROM reserves
WHERE reserves.branchcode = <<Pick your Branch|branches>>
GROUP BY month, year
UNION ALL
SELECT MONTH(reservedate) AS month, YEAR(reservedate) AS Year, count(*) AS count
FROM old_reserves
WHERE old_reserves.branchcode = <<Pick your Branch|branches>>
GROUP BY month, year
) AS myholds
GROUP BY month, year
ORDER BY year DESC, month DESC



