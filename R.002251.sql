/*
R.002251

----------

Name: Active borrowers in a set time period for entire catalog
Created by: Heather Braum

----------

Group: Administrative Reports
     Patron Statistics-admin

Created on: 2014-04-29 09:28:47
Modified on: 2014-04-29 09:28:47
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT count(distinct borrowernumber) FROM statistics WHERE  datetime BETWEEN <<starting date, ex. 2013-01-01>> AND <<ending date, ex. 2013-12-31>>



