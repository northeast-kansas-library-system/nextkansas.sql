/*
R.002032

----------

Name: Overdues for your patrons, limited by collection code
Created by: Heather Braum

----------

Group: Circulation
     Overdues

Created on: 2013-09-06 11:52:04
Modified on: 2014-01-15 15:21:00
Date last run: 2018-12-31 15:13:09

----------

Public: 0
Expiry: 0

----------

Choose branch and collection code

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.surname,'</a>') AS "borrowers.surname", borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.email, borrowers.address, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.ccode, items.itemcallnumber, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/moredetail.pl?itemnumber=',items.itemnumber,'&biblionumber=',biblio.biblionumber,'&bi=',biblioitems.biblioitemnumber,'#item',items.itemnumber,'\" target="_blank">',items.barcode,'</a>') AS barcode, items.homebranch, biblio.title, biblio.author FROM borrowers join issues USING (borrowernumber) join items USING (itemnumber) JOIN biblio USING (biblionumber) join biblioitems USING (biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > 0 and borrowers.branchcode = <<Pick your branch|branches>> AND items.ccode=<<ccode|CCODE>> order by borrowers.surname asc, issues.date_due asc



