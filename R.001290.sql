/*
R.001290

----------

Name: Patrons with CCode checked out
Created by: -

----------

Group: Circulation
     -

Created on: 2012-01-04 14:15:52
Modified on: 2013-11-17 13:49:22
Date last run: 2017-08-01 14:30:02

----------

Public: 0
Expiry: 0

----------

This shows current checkouts by collection code for items belonging to the selected library. #patrons

----------
*/

SELECT issues.date_due, borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.email, biblio.title, biblio.author,        items.itemcallnumber, items.barcode, items.location  FROM issues  LEFT JOIN items ON (issues.itemnumber=items.itemnumber)  LEFT JOIN borrowers ON (issues.borrowernumber=borrowers.borrowernumber)  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)  where items.homebranch=<<Pick your branch|branches>> and items.ccode=<<Pick a Collection Code|CCODE>> ORDER BY issues.date_due ASC



