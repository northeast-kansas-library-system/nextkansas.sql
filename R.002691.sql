/*
R.002691

----------

Name: Materials currently checked out (for end of school year) (grade level)
Created by: Heather Braum

----------

Group: School Libraries
     -

Created on: 2016-05-11 11:11:29
Modified on: 2016-05-11 13:31:51
Date last run: 2025-05-06 12:02:00

----------

Public: 0
Expiry: 0

----------

This one is for students with grade levels set. 

Run <a href="https://staff.nexpresslibrary.org/cgi-bin/koha/reports/guided_reports.pl?reports=2694&phase=Run%20this%20report" target="_blank">report #2694</a> for the list for students (and teachers) without a grade level set. 

----------
*/



SELECT CONCAT(p.firstname, ' ', p.surname, ' Grade: ', ba_GRADE.attribute, ' title: ', b.title, ' by ', b.author, ' barcode: ', i.barcode, '  Owning Library: ', i.homebranch, '    cost if lost: $', i.replacementprice, 'Originally due: ', date(s.date_due), '               ') as message FROM borrowers p left join issues s USING (borrowernumber) left join items i USING (itemnumber) left JOIN biblio b USING (biblionumber) LEFT JOIN borrower_attributes ba_GRADE ON (p.borrowernumber = ba_GRADE.borrowernumber AND ba_GRADE.code = 'GRADE') LEFT JOIN branches br ON (i.homebranch = br.branchname) WHERE s.branchcode = &lt;&gt; AND p.categorycode='STUDENT' AND ba_GRADE.attribute IS NOT NULL order by p.categorycode asc, ba_GRADE.attribute asc, p.sort1 asc, p.surname asc LIMIT 1000

























