/*
R.002029

----------

Name: Multiple ccodes on a single record
Created by: Heather Braum

----------

Group: -
     -

Created on: 2013-09-03 13:59:59
Modified on: 2014-08-30 13:47:48
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "Linked Record", CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\" target="_blank">',b.title,'</a>') AS "Title Search", b.title, b.biblionumber, GROUP_CONCAT(DISTINCT i.ccode SEPARATOR '; ') as ccodes, count(distinct CCODE) as types from biblio b left join items i USING(biblionumber) where b.biblionumber IN (SELECT biblionumber FROM items WHERE ccode='DVD') group by i.biblionumber having count(distinct CCODE) > 1 ORDER BY types DESC


