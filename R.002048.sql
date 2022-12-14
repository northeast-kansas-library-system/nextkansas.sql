/*
R.002048

----------

Name: Overdues for School Patrons
Created by: Heather Braum

----------

Group: School Libraries
     Overdues (schools)

Created on: 2013-10-08 17:52:04
Modified on: 2014-08-19 22:32:52
Date last run: 2022-11-11 07:25:15

----------

Public: 0
Expiry: 0

----------

Put in the minimum number of days overdue, choose your branch and Run the report. 

----------
*/



SELECT p.categorycode, ba_GRADE.attribute AS grade, p.sort1, CONCAT(p.firstname, ' ', p.surname) AS name, b.title, b.author, i.homebranch as "owning library", i.ccode, i.itemcallnumber, i.barcode, s.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', CONCAT('$', i.replacementprice, ' replacement fee if lost') FROM borrowers p left join issues s USING (borrowernumber) left join items i USING (itemnumber) left JOIN biblio b USING (biblionumber) LEFT JOIN borrower_attributes ba_GRADE ON (p.borrowernumber = ba_GRADE.borrowernumber AND ba_GRADE.code = 'GRADE') WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > <<number of days>> and s.branchcode = <<Pick your branch|branches>> order by p.categorycode asc, ba_GRADE.attribute asc, p.sort1 asc, p.surname asc LIMIT 1000

























