/*
R.000575

----------

Name: OVERDUE LIST - For Shelf Check
Created by:  Tongie Book Club

----------

Group: Circulation
     Overdues

Created on: 2009-06-12 14:19:42
Modified on: 2013-06-17 02:05:26
Date last run: 2020-08-12 17:42:32

----------

Public: 0
Expiry: 0

----------

Simplified report of overdue items for shelf check

----------
*/

SELECT items.itemcallnumber,  biblio.title, biblio.author, items.itype, items.ccode, items.location,  items.barcode, borrowers.cardnumber FROM borrowers left join issues USING (borrowernumber) LEFT JOIN items USING (itemnumber) LEFT JOIN biblio USING (biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) >= '2' and issues.branchcode = <<Pick your branch|branches>> order by items.itemcallnumber asc



