/*
R.002294

----------

Name: Holds that are Older than Three Months
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2014-07-01 12:50:17
Modified on: 2015-04-07 10:00:52
Date last run: 2018-09-11 11:37:22

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a target="_blank" href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',b.biblionumber,'\">'"Hold Link"'</a>') AS "Hold Link", CONCAT('<a target="_blank" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\">'"Title Link"'</a>') AS "Title Link", p.firstname, p.surname, r.reservedate, b.title, 
CASE WHEN CURDATE() > p.dateexpiry THEN 'true' ELSE 'false' END as "patron expired", p.dateexpiry
FROM reserves r
    LEFT JOIN borrowers p USING (borrowernumber)
    LEFT JOIN biblio b  USING (biblionumber)
WHERE  r.reservedate < ADDDATE(NOW(), INTERVAL -3 MONTH)
    AND  r.branchcode = <<Select your library|branches>>     
ORDER BY r.reservedate




