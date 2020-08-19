/*
R.000820

----------

Name: Patron Category cleanup
Created by:  Tongie Book Club

----------

Group: Patrons
     Fix Patrons

Created on: 2010-02-18 13:34:22
Modified on: 2014-04-21 14:50:32
Date last run: 2020-07-02 12:54:19

----------

Public: 0
Expiry: 0

----------

Edit branchcode and categorycode scheme. Find potential patron category errors. 

----------
*/

SELECT borrowers.cardnumber, borrowers.surname, borrowers.firstname, borrowers.categorycode FROM borrowers LEFT JOIN categories USING(categorycode) WHERE borrowers.branchcode=<<Enter patrons library|branches>> AND categories.categorycode=<<Patron Category|categorycode>>  AND borrowers.categorycode != 'STAFF'



