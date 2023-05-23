/*
R.001186

----------

Name: Old Holds
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2011-09-06 16:58:22
Modified on: 2013-09-25 17:18:34
Date last run: 2023-04-14 10:48:05

----------

Public: 0
Expiry: 0

----------

Report that shows holds placed prior to a certain date and are still active. Enhanced. Click Run and then choose your library from the dropdown list. #holds

----------
*/



SELECT borrowers.firstname, borrowers.surname, borrowers.phone, borrowers.branchcode, biblio.title, biblio.author, items.ccode, items.itype, items.barcode, reserves.reservedate FROM reserves JOIN items USING (biblionumber) JOIN biblio using (biblionumber) JOIN borrowers using (borrowernumber) WHERE reserves.reservedate < <<Starting Date (yyyy-mm-dd format)>> AND reserves.found IS NULL AND borrowers.branchcode = <<Select your library|branches>> GROUP BY borrowers.branchcode, borrowers.surname, items.ccode asc

























