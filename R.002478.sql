/*
R.002478

----------

Name: Active borrowers count in last 6 months and 1 year
Created by: Heather Braum

----------

Group: Patrons
     Patron Statistics

Created on: 2015-03-31 12:01:48
Modified on: 2015-08-20 10:15:20
Date last run: 2020-09-22 16:21:39

----------

Public: 0
Expiry: 0

----------

Gives a count of active borrowers interacting at your library (interaction=they have checked out, renewed, or checked in items), during a certain time period.

----------
*/

SELECT @1:="Last 6 months: Active Unique Borrowers" AS "Active Borrowers", count(DISTINCT s.borrowernumber) AS "Count" FROM statistics s WHERE s.branch = <<Choose library|branches>>AND s.datetime >= date_sub(now(), interval 6 month)

UNION


SELECT @1:="Last 1 year: Active Unique Borrowers", count(DISTINCT s.borrowernumber)  FROM statistics s WHERE s.branch=<<Choose library|branches>> AND s.datetime >= date_sub(now(), interval 1 year)

UNION

SELECT @1:="Last 6 months: Active Unique Registered Borrowers", count(DISTINCT s.borrowernumber) FROM statistics s LEFT JOIN borrowers b USING(borrowernumber) WHERE s.branch=<<Choose library|branches>> AND b.branchcode=<<Choose library|branches>> AND s.datetime >= date_sub(now(), interval 6 month)

UNION

SELECT @1:="Last 1 year: Active Unique Registered Borrowers", count(DISTINCT s.borrowernumber) FROM statistics s LEFT JOIN borrowers b USING(borrowernumber) WHERE s.branch=<<Choose library|branches>> AND b.branchcode=<<Choose library|branches>> AND s.datetime >= date_sub(now(), interval 1 year)



