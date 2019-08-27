/*
R.002231

----------

Name: Rossville Holds to Check on
Created by: Heather Braum

----------

Group: Library-Specific
     Rossville

Created on: 2014-03-24 14:22:02
Modified on: 2014-03-24 15:39:01
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',r.biblionumber,'\" target="_blank">',r.biblionumber,'</a>') AS "Holds Link", CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',r.biblionumber,'\" target="_blank">',b.title,'</a>') AS "Title Link", r.reservedate FROM reserves r LEFT JOIN biblio b USING(biblionumber)
WHERE biblionumber IN ('371573','476465','476465','515448','588119') GROUP BY biblionumber






