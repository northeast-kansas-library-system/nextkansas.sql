/*
R.002501

----------

Name: Holds Project for deduping
Created by: Heather Braum

----------

Group: Administrative Reports
     Duplicate Records-admin

Created on: 2015-05-20 11:26:37
Modified on: 2015-05-20 15:03:04
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>') AS Record , title, author, count(reserves.reserve_id) FROM reserves LEFT JOIN biblio USING(biblionumber) WHERE biblio.biblionumber IN (SELECT biblionumber FROM old_reserves WHERE timestamp LIKE '2015-05-20%') OR reserves.reservedate < '2015-05-21' GROUP BY biblio.biblionumber ORDER BY title, author LIMIT 10000



