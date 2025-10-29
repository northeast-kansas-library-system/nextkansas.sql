/*
R.001805

----------

Name: Current Checked out List, Limited by School & Grade
Created by: Heather Braum

----------

Group: School Libraries
     -

Created on: 2013-04-22 09:29:08
Modified on: 2015-03-12 14:01:28
Date last run: 2025-05-14 09:19:12

----------

Public: 0
Expiry: 0

----------

(for school libraries)

----------
*/



select borrower_attributes.attribute as 'grade', borrowers.cardnumber, borrowers.firstname as "first name", borrowers.surname as "last name", borrowers.categorycode AS "patron type", borrowers.sort1 as "teacher", biblio.title as "book title", biblio.author as "author", items.ccode as "collection code", items.itype, items.replacementprice as "replacement price", items.itemcallnumber as "call number", items.barcode as "barcode", issues.issuedate as "date checked out", issues.date_due as "date due", CONCAT(''"patron check out"'') as "patron checkout screen" from borrowers LEFT JOIN borrower_attributes USING (borrowernumber) left join issues USING (borrowernumber) left join items USING (itemnumber) left JOIN biblio USING (biblionumber) where borrowers.branchcode =<>  AND borrower_attributes.attribute=<> GROUP BY items.barcode ORDER BY grade, teacher, "last name", "first name", "book title" LIMIT 1000

























