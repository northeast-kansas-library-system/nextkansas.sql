/*
R.001530

----------

Name: Overdue List - XX days past due (linked)
Created by: Heather Braum

----------

Group: Circulation
     Overdues

Created on: 2012-08-29 12:24:30
Modified on: 2014-01-15 14:07:31
Date last run: 2021-02-04 14:25:13

----------

Public: 0
Expiry: 0

----------

This is a duplication of report #350 with two differences: the surname & the barcode are linked to the borrower & item view screens. #overdues

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.surname,'</a>') AS "borrowers.surname", borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.email, borrowers.address, borrowers.address2, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/moredetail.pl?itemnumber=',items.itemnumber,'&biblionumber=',biblio.biblionumber,'&bi=',biblioitems.biblioitemnumber,'#item',items.itemnumber,'\" target="_blank">',items.barcode,'</a>') AS barcode, items.homebranch, biblio.title, biblio.author FROM borrowers join issues USING (borrowernumber) join items USING (itemnumber) JOIN biblio USING (biblionumber) join biblioitems USING (biblionumber) WHERE issues.branchcode = <<Pick your branch|branches>> AND (TO_DAYS(curdate())-TO_DAYS(date_due)) > <<number of days>> order by borrowers.surname asc, issues.date_due asc



