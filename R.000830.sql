/*
R.000830

----------

Name: Bonner Accounts
Created by: NEKLS Administrator

----------

Group: Library-Specific
     Bonner Springs

Created on: 2010-03-23 11:51:34
Modified on: 2015-12-05 20:45:12
Date last run: 2018-10-07 16:37:34

----------

Public: 0
Expiry: 0

----------

Shows accountlines.amountoutstanding for Bonner. 

----------
*/

SELECT borrowers.cardnumber,borrowers.surname,borrowers.firstname,borrowers.branchcode,borrowers.categorycode,accountlines.amountoutstanding FROM borrowers LEFT JOIN accountlines on (borrowers.borrowernumber=accountlines.borrowernumber)   WHERE borrowers.branchcode='BONNERSPGS' GROUP BY accountlines.amountoutstanding ORDER BY accountlines.amountoutstanding desc



