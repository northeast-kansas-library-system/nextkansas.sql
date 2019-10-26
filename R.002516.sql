/*
R.002516

----------

Name: Monthly Fines Report 2
Created by: Robin Hastings

----------

Group: -
     -

Created on: 2015-05-28 10:30:15
Modified on: 2015-05-28 10:39:37
Date last run: 2019-03-11 13:30:04

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT accounttype, COUNT(*) from accountlines LEFT JOIN borrowers USING (borrowernumber) WHERE borrowers.branchcode="EUDORA" AND year(date)="2015" AND month(date)="04" GROUP BY accounttype


