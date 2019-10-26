/*
R.002226

----------

Name: Winchester Holds to Clear
Created by: Heather Braum

----------

Group: Library-Specific
     Winchester

Created on: 2014-03-24 13:29:27
Modified on: 2014-03-24 13:31:41
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',r.biblionumber,'\" target="_blank">',r.biblionumber,'</a>') AS "Holds Link", CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',r.biblionumber,'\" target="_blank">',b.title,'</a>') AS "Title Link", r.reservedate FROM reserves r LEFT JOIN biblio b USING(biblionumber)
WHERE biblionumber IN ('76011','489142','587653','582497','422706') GROUP BY biblionumber


