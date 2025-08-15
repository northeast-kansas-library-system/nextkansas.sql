/*
R.000820

----------

Name: Patron Category cleanup
Created by:  Tongie Book Club

----------

Group: Borrowers
     Fix Patrons

Created on: 2010-02-18 13:34:22
Modified on: 2014-04-21 14:50:32
Date last run: 2025-07-03 11:21:53

----------

Public: 0
Expiry: 0

----------

Edit branchcode and categorycode scheme. Find potential patron category errors. 

----------
*/



SELECT borrowers.cardnumber, borrowers.surname, borrowers.firstname, borrowers.categorycode FROM borrowers LEFT JOIN categories USING(categorycode) WHERE borrowers.branchcode=&lt;&gt; AND categories.categorycode=&lt;&gt;  AND borrowers.categorycode != 'STAFF'

























