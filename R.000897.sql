/*
R.000897

----------

Name: Patrons list with expiry date
Created by: NEKLS Administrator

----------

Group: School Libraries
     Students

Created on: 2010-08-02 13:04:35
Modified on: 2015-04-29 17:31:09
Date last run: 2019-08-02 10:06:53

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT cardnumber, surname, firstname,debarred, dateexpiry FROM borrowers WHERE branchcode=<<branch|branches>> ORDER BY surname



