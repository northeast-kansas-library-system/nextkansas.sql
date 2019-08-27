/*
R.002103

----------

Name: Borrowers w accountlines over 25 lines
Created by: Heather Braum

----------

Group: Administrative Reports
     Slow Patrons - admin

Created on: 2013-11-19 09:26:18
Modified on: 2014-08-09 00:37:01
Date last run: -

----------

Public: 0
Expiry: 0

----------

To troubleshoot slow-loading borrower accounts

----------
*/

SELECT borrowernumber, count(accountlines_id) FROM accountlines GROUP BY borrowernumber HAVING count(accountlines_id) > 25



