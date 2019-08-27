/*
R.000979

----------

Name: Patron Notes and Attribute
Created by: -

----------

Group: Patrons
     Patron attributes

Created on: 2010-11-17 14:24:06
Modified on: 2019-07-24 21:47:21
Date last run: 2019-07-24 21:44:26

----------

Public: 0
Expiry: 0

----------

Enhanced - Pick your branch to see borrower notes and attribute notes (DL/SSN) info for all of your patrons

<p><span style="background-color: darkred; color: white">Scheduled for deletion on August 31, 2019</p>

Replaced by 3235 among others

----------
*/

SELECT borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.branchcode, borrowers.borrowernotes, GROUP_CONCAT(borrower_attributes.attribute SEPARATOR ', ') as extras
FROM borrowers LEFT JOIN borrower_attributes USING(borrowernumber) WHERE borrower_attributes.attribute <> '' GROUP BY borrowers.borrowernumber ORDER BY borrowers.branchcode, borrowers.surname



