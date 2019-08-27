/*
R.001849

----------

Name: List of Doniphan Statistical Patron ACcounts
Created by: Heather Braum

----------

Group: Library-Specific
     -

Created on: 2013-05-17 12:44:05
Modified on: 2014-04-25 16:06:07
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowers.borrowernumber, CONCAT (firstname, ' ', surname) as name, statistics.type, count(statistics.datetime) FROM borrowers LEFT JOIN statistics USING(borrowernumber) WHERE borrowers.branchcode="DONITROY" AND borrowers.categorycode="STATISTIC" GROUP BY borrowers.borrowernumber, statistics.type



