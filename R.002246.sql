/*
R.002246

----------

Name: List of Items Checked out at your library (linked)
Created by: Heather Braum

----------

Group: Circulation
     Checked Out

Created on: 2014-04-23 14:03:20
Modified on: 2014-04-23 14:11:43
Date last run: 2017-11-22 09:37:32

----------

Public: 0
Expiry: 0

----------

This report includes links to the patron account and the item's record. Companion to #2245. This report limits on items' home library and displays the cardnumber, patron's home library, patron name, item title, location, collection code, item type, item barcode, date checked out, days checked out, date due, days overdue, last date renewed, renewals count, of all materials currently checked out from your library's collection. It is ordered by the number of days checked out, longest to shortest. 

----------
*/

select CONCAT('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.cardnumber,'</a>') as "patron account",borrowers.branchcode as homelibrary, borrowers.firstname, borrowers.surname, CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.title,'</a>') as title,items.itemcallnumber as callnumber, items.location, items.ccode, items.itype, items.barcode, DATE(issues.issuedate) as "date out", (TO_DAYS(curdate())-TO_DAYS(issuedate)) as daysout, DATE(issues.date_due) AS "date due", (TO_DAYS(curdate())-TO_DAYS(date_due)) as 'days overdue', date(issues.lastreneweddate) as 'last renewed', issues.renewals  from issues join borrowers USING(borrowernumber) join items using(itemnumber) join biblio using(biblionumber)  where items.homebranch=<<branch|branches>>  ORDER BY daysout DESC



