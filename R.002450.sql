/*
R.002450

----------

Name: unknown
Created by: CORNING TECH

----------

Group: -
     -

Created on: 2015-01-26 14:13:47
Modified on: 2015-12-09 15:27:46
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

select surname, firstname, GROUP_CONCAT(cardnumber SEPARATOR ', ') as barcodes, GROUP_CONCAT(borrowernumber SEPARATOR ', ') as borrowers, GROUP_CONCAT(branchcode SEPARATOR ', ') as "home libraries" from borrowers group by CONCAT(surname,'-',firstname,'/') HAVING COUNT(CONCAT(surname,'-',firstname,'/'))>1



