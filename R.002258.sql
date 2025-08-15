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
Date last run: 2024-03-01 12:10:12

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT CONCAT ('',borrowers.surname,'') AS "borrowers.surname", borrowers.firstname, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', CONCAT ('',items.barcode,'') AS barcode, items.homebranch FROM borrowers join issues USING (borrowernumber) join items USING (itemnumber) join biblio USING(biblionumber) join biblioitems USING (biblionumber) WHERE items.homebranch = &lt;&gt; AND (TO_DAYS(curdate())-TO_DAYS(issues.date_due)) &gt; &lt;&gt; order by issues.date_due desc

























