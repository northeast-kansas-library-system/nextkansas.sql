/*
R.002349

----------

Name: Possible Duplicate patrons
Created by: Heather Braum

----------

Group: Borrowers
     Fix Patrons

Created on: 2014-09-02 20:38:05
Modified on: 2017-02-20 16:34:56
Date last run: 2021-06-30 10:10:02

----------

Public: 0
Expiry: 0

----------



----------
*/

select surname, firstname, GROUP_CONCAT(cardnumber SEPARATOR ', ') as barcodes, GROUP_CONCAT(borrowernumber SEPARATOR ', ') as borrowers, GROUP_CONCAT(branchcode SEPARATOR ', ') as "home libraries" from borrowers WHERE branchcode IN ('PAOLA','OSAWATOMIE') group by CONCAT(surname,'-',firstname,'/') HAVING COUNT(CONCAT(surname,'-',firstname,'/'))>1



