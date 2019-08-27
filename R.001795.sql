/*
R.001795

----------

Name: Overdues for School Library Students
Created by: Heather Braum

----------

Group: School Libraries
     Overdues (schools)

Created on: 2013-04-16 09:39:22
Modified on: 2014-08-19 22:29:18
Date last run: 2018-09-28 13:32:52

----------

Public: 0
Expiry: 0

----------

Will not work for teachers at this time. #overdues

----------
*/

SELECT borrower_attributes.attribute as 'grade', CONCAT (borrowers.firstname,' ',borrowers.surname) AS name, biblio.title, biblio.author, issues.date_due, items.itemcallnumber AS callnumber,  items.replacementprice AS price FROM borrower_attributes LEFT JOIN borrowers USING (borrowernumber) left join issues USING (borrowernumber) left join items USING (itemnumber) left JOIN biblio USING (biblionumber) left join biblioitems USING (biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > '1' and issues.branchcode = <<Pick your branch|branches>> and borrower_attributes.code IN ('GRADE')  order by borrower_attributes.attribute asc, borrowers.surname asc, issues.date_due asc LIMIT 200



