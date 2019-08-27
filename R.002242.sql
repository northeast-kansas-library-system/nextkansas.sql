/*
R.002242

----------

Name: Active patrons during a date range
Created by: Heather Braum

----------

Group: Administrative Reports
     Patron Statistics-admin

Created on: 2014-04-18 14:20:09
Modified on: 2014-08-09 00:28:45
Date last run: -

----------

Public: 0
Expiry: 0

----------

Active patrons during a date range (have interactions in the stats table)

----------
*/

SELECT count(distinct borrowers.borrowernumber) FROM statistics, borrowers WHERE statistics.borrowernumber=borrowers.borrowernumber AND statistics.datetime BETWEEN <<starting date, ex. 2013-01-01>> AND <<ending date, ex. 2013-12-31>>



