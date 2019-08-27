/*
R.001984

----------

Name: Multiple itypes on a single record
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Items-admin

Created on: 2013-08-12 14:12:53
Modified on: 2013-11-17 12:36:19
Date last run: 2018-10-03 10:26:48

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "Linked Record", CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\" target="_blank">',b.title,'</a>') AS "Title Search", b.title, b.biblionumber, count(distinct itype) as types from biblio b left join items i USING(biblionumber) group by i.biblionumber having count(distinct itype) > 1 ORDER BY types DESC



