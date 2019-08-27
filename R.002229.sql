/*
R.002229

----------

Name: Valley Falls Holds to Follow Up On
Created by: Heather Braum

----------

Group: Library-Specific
     Valley Falls

Created on: 2014-03-24 14:05:55
Modified on: 2014-03-24 14:05:55
Date last run: 2017-08-28 16:15:38

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',r.biblionumber,'\" target="_blank">',r.biblionumber,'</a>') AS "Holds Link", CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',r.biblionumber,'\" target="_blank">',b.title,'</a>') AS "Title Link", r.reservedate FROM reserves r LEFT JOIN biblio b USING(biblionumber)
WHERE biblionumber IN ('549865','9147','587956','595228') GROUP BY biblionumber





