/*
R.002277

----------

Name: Libraries that should received overdue notice email to library email tomorrow
Created by: Heather Braum

----------

Group: Circulation
     Overdues

Created on: 2014-06-05 17:53:15
Modified on: 2014-06-05 17:54:08
Date last run: 2017-11-29 18:12:41

----------

Public: 0
Expiry: 0

----------

Predicts which libraries and count of distinct patrons that have items 6/20/34 days overdue (typically - differs for a few libraries), don't have email accounts, and the library email should be sent an overdue notice for them tomorrow. 

----------
*/

SELECT i.branchcode, count(DISTINCT b.borrowernumber) as "patron count", br.branchemail as 'number of patrons' FROM borrowers b, issues i, branches br 
WHERE 
b.borrowernumber=i.borrowernumber AND 
i.branchcode=br.branchcode AND 
b.email = '' AND 
b.categorycode NOT IN ('STUDENT','ILL','AATEMP','STAFF','OPAC-SELF','BOARD','HORT-SPCL','HOMEBOUND','STATISTIC') AND 
((i.branchcode IN ('BALDWIN','BERN','BONNERSPGS','CARBONDALE','CENTRALIA','CORNING','DONIELWD','DONIHIGH','DONITROY','DONIWATH','EFFINGHAM','EUDORA','EVEREST','HIAWATHA','HOLTON','LANSING','LEAVENWRTH','LINWOOD','LYNDON','MCLOUTH','MERIDEN','NEKLS','NORTONVLLE','OSAGECITY','OSAWATOMIE','OSKALOOSA','OTTAWA','OVERBROOK','PERRY','POMONA','SABETHA','SENECA','SILVERLAKE','VALLEYFALL','WELLSVILLE','WILLIAMSBG','WINCHESTER') AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('6','20','34'))
OR 
(i.branchcode IN ('RICHMOND','TONGANOXIE') AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('6','20','59')) OR 
(i.branchcode = 'WETMORE' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('0','2','6')) OR 
(i.branchcode = 'BURLINGAME' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('6','13','20')) OR 
(i.branchcode = 'HORTON' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('6','20','29')) OR 
(i.branchcode = 'ATCHISON' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('9','34','89')) OR 
(i.branchcode = 'BASEHOR' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('13','34','89')) OR 
(i.branchcode = 'ROSSVILLE' AND (TO_DAYS(curdate())-TO_DAYS(i.date_due)) IN ('6','34','179'))) 
GROUP BY i.branchcode ORDER BY i.branchcode



