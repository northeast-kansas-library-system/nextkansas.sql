/*
R.000574

----------

Name: Monthly 004 New Patrons by Category
Created by: NEKLS Administrator

----------

Group: -
     -

Created on: 2009-06-12 12:26:02
Modified on: 2016-10-05 16:17:10
Date last run: 2019-03-06 10:10:11

----------

Public: 0
Expiry: 0

----------

Teri: Run, add month and year, then save output.

----------
*/

SELECT branchcode as "Library",categorycode as "Patron Category",COUNT(*) as "Total Patrons"
FROM borrowers WHERE month(dateenrolled) = <<Choose Month|MONTH>> AND year(dateenrolled) = <<Choose Year|YEAR>>
GROUP BY branchcode,categorycode 
ORDER BY branchcode


