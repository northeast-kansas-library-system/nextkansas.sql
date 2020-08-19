/*
R.002253

----------

Name: Checked Out Items at School Libraries
Created by: Heather Braum

----------

Group: School Libraries
     Overdues (schools)

Created on: 2014-05-05 22:52:24
Modified on: 2014-08-19 22:32:48
Date last run: 2020-07-03 13:06:52

----------

Public: 0
Expiry: 0

----------

Includes grade, classroom teacher where applicable, due dates of materials, replacement fees, and more. 

----------
*/

SELECT p.categorycode, ba_GRADE.attribute AS grade, p.sort1, CONCAT(p.firstname, ' ', p.surname) AS name, b.title, b.author, i.homebranch as "owning library", i.ccode, i.itemcallnumber, i.barcode, s.date_due, CONCAT('$', i.replacementprice, ' replacement fee if lost') FROM borrowers p left join issues s USING (borrowernumber) left join items i USING (itemnumber) left JOIN biblio b USING (biblionumber) LEFT JOIN borrower_attributes ba_GRADE ON (p.borrowernumber = ba_GRADE.borrowernumber AND ba_GRADE.code = 'GRADE') WHERE s.branchcode = <<Pick your branch|branches>> order by p.categorycode asc, ba_GRADE.attribute asc, p.sort1 asc, p.surname asc LIMIT 1000



