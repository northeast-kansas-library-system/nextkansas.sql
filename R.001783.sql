/*
R.001783

----------

Name: Count of authors in a series
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2013-04-02 17:35:07
Modified on: 2014-01-15 14:31:14
Date last run: 2019-05-29 23:03:58

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=au&q=',author,'&sort_by=title_az\" target="_blank">',author,'</a>') AS "Author Search" , count(biblionumber) FROM biblio WHERE seriestitle LIKE <<enter series title>> GROUP BY author

























