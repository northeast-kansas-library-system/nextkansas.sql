/*
R.001953

----------

Name: Patrons by Category, Date of Birth, Branch
Created by: -

----------

Group: Borrowers
     -

Created on: 2013-07-21 22:08:53
Modified on: 2013-11-17 12:09:42
Date last run: 2021-09-10 12:58:21

----------

Public: 0
Expiry: 0

----------

mc

----------
*/



SELECT surname,firstname,categorycode,dateofbirth,cardnumber,address,city,phone,email FROM borrowers WHERE dateofbirth LIKE '1996%' AND categorycode NOT LIKE '%J' ORDER BY surname

























