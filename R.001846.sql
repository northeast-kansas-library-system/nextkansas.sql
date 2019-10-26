/*
R.001846

----------

Name: Statistical Patrons for Doniphan Troy, Circ Counts
Created by: Heather Braum

----------

Group: Library-Specific
     -

Created on: 2013-05-17 11:43:48
Modified on: 2013-06-16 16:37:10
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowers.borrowernumber, CONCAT (borrowers.firstname, ' ', borrowers.surname) AS 'name', statistics.type, count(statistics.datetime) AS circs FROM borrowers LEFT JOIN statistics USING(borrowernumber) WHERE borrowers.categorycode='STATISTIC' AND borrowers.branchcode='DONITROY' AND statistics.type IN ('issue','renew','localuse') GROUP BY borrowers.borrowernumber, statistics.type ORDER BY name


