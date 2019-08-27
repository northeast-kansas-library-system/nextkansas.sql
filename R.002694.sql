/*
R.002694

----------

Name: Materials currently checked out (for end of school year) (no grade level)
Created by: Heather Braum

----------

Group: School Libraries
     -

Created on: 2016-05-11 13:29:58
Modified on: 2016-05-11 13:32:20
Date last run: -

----------

Public: 0
Expiry: 0

----------

This one is for students (and teachers) without grade levels set. 

Run <a href="https://staff.nexpresslibrary.org/cgi-bin/koha/reports/guided_reports.pl?reports=2691&phase=Run%20this%20report" target="_blank">report #2691</a> for the list for students with a grade level set. 

----------
*/

SELECT CONCAT(p.firstname, ' ', p.surname, '<br /> <br />title: ', b.title, '<br /> <br />by ', b.author, '<br /> <br />barcode: ', i.barcode, '<br /> <br /> Owning Library: ', i.homebranch, '<br /> <br /> <br /> <br /> cost if lost: $', i.replacementprice, '<br /><br />Originally due: ', date(s.date_due), '<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />') as message FROM borrowers p left join issues s USING (borrowernumber) left join items i USING (itemnumber) left JOIN biblio b USING (biblionumber) LEFT JOIN borrower_attributes ba_GRADE ON (p.borrowernumber = ba_GRADE.borrowernumber AND ba_GRADE.code = 'GRADE') LEFT JOIN branches br ON (i.homebranch = br.branchname) WHERE s.branchcode = <<Pick your branch|branches>> AND ba_GRADE.code IS NULL order by p.categorycode asc, ba_GRADE.attribute asc, p.sort1 asc, p.surname asc LIMIT 1000



