/*
R.002244

----------

Name: List of Items Checked out in a Collection Code
Created by: Heather Braum

----------

Group: Circulation
     Checked Out

Created on: 2014-04-23 13:48:23
Modified on: 2014-04-23 14:10:57
Date last run: 2019-08-12 16:23:06

----------

Public: 0
Expiry: 0

----------

This report limits on items' home library and collection code, and displays the cardnumber, patron's home library, patron name, item title, location, collection code, item type, item barcode, date checked out, days checked out, date due, days overdue, last date renewed, renewals count, of all materials currently checked out from your library's collection. 

----------
*/

select borrowers.cardnumber, borrowers.branchcode as homelibrary, borrowers.firstname, borrowers.surname, biblio.title, items.itemcallnumber as callnumber, items.location, items.ccode, items.itype, items.barcode, DATE(issues.issuedate) as "date out", (TO_DAYS(curdate())-TO_DAYS(issuedate)) as daysout, DATE(issues.date_due) AS "date due", (TO_DAYS(curdate())-TO_DAYS(date_due)) as "days overdue", date(issues.lastreneweddate) as "last renewed", issues.renewals  from issues join borrowers USING(borrowernumber) join items using(itemnumber) join biblio using(biblionumber)  where items.homebranch=<<branch|branches>> AND items.ccode=<<ccode|CCODE>> ORDER BY daysout DESC



