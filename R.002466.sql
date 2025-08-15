/*
R.002466

----------

Name: PATRON LIST WITH EMAIL, PHONE, CITY & ZIP
Created by: -

----------

Group: Borrowers
     -

Created on: 2015-02-19 14:40:15
Modified on: 2015-02-23 09:29:39
Date last run: 2025-06-27 16:53:24

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT email, phone, B_phone, cardnumber, surname, firstname, zipcode, city, debarred, dateexpiry FROM borrowers WHERE branchcode=&lt;&gt; ORDER BY branchcode, surname ASC

























