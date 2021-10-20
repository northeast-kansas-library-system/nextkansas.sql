/*
R.002516

----------

Name: Monthly Fines Report 2
Created by: Robin Hastings

----------

Group: -
     -

Created on: 2015-05-28 10:30:15
Modified on: 2019-12-26 11:46:17
Date last run: 2019-03-11 13:30:04

----------

Public: 0
Expiry: 0

----------

<p><span style="color: yellow; background-color: red; font-size: 200%;">References accountlines.accounttype.  Needs to be updated after January 4, 2020</span></p>

----------
*/



SELECT accounttype, COUNT(*) from accountlines LEFT JOIN borrowers USING (borrowernumber) WHERE borrowers.branchcode="EUDORA" AND year(date)="2015" AND month(date)="04" GROUP BY accounttype

























