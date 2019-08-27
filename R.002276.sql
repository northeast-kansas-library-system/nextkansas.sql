/*
R.002276

----------

Name: Libraries that should have received overdue notice email to library email today
Created by: Heather Braum

----------

Group: Circulation
     Overdues

Created on: 2014-06-05 17:48:31
Modified on: 2014-06-05 17:54:01
Date last run: 2017-11-29 18:12:12

----------

Public: 0
Expiry: 0

----------

Shows branches and count of distinct patrons that have items 7/21/35 days overdue (typically - differs at a few libraries), don't have email accounts, and the library email should have been sent an overdue notice for them. Report #2273 shows specific patrons. 

----------
*/

SELECT i.branchcode, count(DISTINCT b.borrowernumber) as "patron count", br.branchemail as 'number of patrons' FROM borrowers b, issues i, branches br WHERE b.borrowernumber=i.borrowernumber AND i.branchcode=br.branchcode AND b.email = '' AND b.categorycode NOT IN ('STUDENT','ILL','AATEMP','STAFF','OPAC-SELF','BOARD','HORT-SPCL','HOMEBOUND','STATISTIC') AND ((i.branchcode IN ('BALDWIN','BERN','BONNERSPGS','CARBONDALE','CENTRALIA','CORNING','DONIELWD','DONIHIGH','DONITROY','DONIWATH','EFFINGHAM','EUDORA','EVEREST','HIAWATHA','HOLTON','LANSING','LEAVENWRTH','LINWOOD','LYNDON','MCLOUTH','MERIDEN','NEKLS','NORTONVLLE','OSAGECITY','OSAWATOMIE','OSKALOOSA','OTTAWA','OVERBROOK','PERRY','POMONA','SABETHA','SENECA','SILVERLAKE','VALLEYFALL','WELLSVILLE','WILLIAMSBG','WINCHESTER') AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('7','21','35'))
OR (i.branchcode IN ('RICHMOND','TONGANOXIE') AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('7','21','60')) OR (i.branchcode = 'WETMORE' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('1','3','7')) OR (i.branchcode = 'BURLINGAME' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('7','14','21')) OR (i.branchcode = 'HORTON' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('7','21','30')) OR (i.branchcode = 'ATCHISON' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('10','35','90')) OR (i.branchcode = 'BASEHOR' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('14','35','90')) OR (i.branchcode = 'ROSSVILLE' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('7','35','180'))) GROUP BY i.branchcode ORDER BY i.branchcode LIMIT 60



