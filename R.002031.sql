/*
R.002031

----------

Name: List of short (under 13 characters) patron cardnumbers
Created by: Heather Braum

----------

Group: Borrowers
     Fix Patrons

Created on: 2013-09-06 10:25:45
Modified on: 2013-11-17 12:00:01
Date last run: 2022-11-09 16:11:53

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT firstname, surname, cardnumber, length(cardnumber), branchcode, categorycode, dateenrolled, dateexpiry FROM borrowers WHERE length(cardnumber) < '13' AND branchcode NOT LIKE 'PH%' ORDER BY length(cardnumber) ASC LIMIT 5000

























