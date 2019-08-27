/*
R.001974

----------

Name: Author search/count of bib records
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2013-08-07 00:20:22
Modified on: 2013-08-16 10:06:55
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblio.author, CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=au&q=',biblio.author,'&sort_by=title_az\" target="_blank">',biblio.author,'</a>') as "author search", count(DISTINCT biblio.biblionumber) as count FROM biblio LEFT JOIN items USING(biblionumber) WHERE items.homebranch IN ('PHAXTELL','PHSMS','PHSES','PHSHS','PHWAC') GROUP BY biblio.author ORDER BY count DESC



