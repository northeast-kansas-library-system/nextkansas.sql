/*
R.002704

----------

Name: AATEMP
Created by: OVERBROOK TECH

----------

Group: Patrons
     Fix Patrons

Created on: 2016-07-05 11:39:42
Modified on: 2016-07-05 11:39:42
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT sum(borrowers.categorycode), borrowers.categorycode FROM borrowers  GROUP BY borrowers.categorycode ORDER BY borrowers.categorycode asc



