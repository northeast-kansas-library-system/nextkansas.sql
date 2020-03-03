/*
R.002258

----------

Name: Overdue Items XXX days Overdue, to Mark Items Lost
Created by: Heather Braum

----------

Group: Circulation
     Overdues

Created on: 2014-05-14 09:33:20
Modified on: 2014-05-14 09:34:38
Date last run: 2020-01-27 12:18:47

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.surname,'</a>') AS "borrowers.surname", borrowers.firstname, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', CONCAT ('<a href=\"/cgi-bin/koha/catalogue/moredetail.pl?itemnumber=',items.itemnumber,'&biblionumber=',biblio.biblionumber,'&bi=',biblioitems.biblioitemnumber,'#item',items.itemnumber,'\" target="_blank">',items.barcode,'</a>') AS barcode, items.homebranch FROM borrowers join issues USING (borrowernumber) join items USING (itemnumber) join biblio USING(biblionumber) join biblioitems USING (biblionumber) WHERE items.homebranch = <<Pick your branch|branches>> AND (TO_DAYS(curdate())-TO_DAYS(issues.date_due)) > <<number of days>> order by issues.date_due desc



