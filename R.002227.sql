/*
R.002227

----------

Name: Williamsburg Holds to Check
Created by: Heather Braum

----------

Group: Library-Specific
     Williamsburg

Created on: 2014-03-24 13:39:46
Modified on: 2014-03-24 14:18:34
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',r.biblionumber,'\" target="_blank">',r.biblionumber,'</a>') AS "Holds Link", CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',r.biblionumber,'\" target="_blank">',b.title,'</a>') AS "Title Link", r.reservedate FROM reserves r LEFT JOIN biblio b USING(biblionumber)
WHERE biblionumber IN ('16979','76072','132503','370845','374819','379430','445792','491389','504090','296416','325425','430982','574490','430982') GROUP BY biblionumber



