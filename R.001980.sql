/*
R.001980

----------

Name: Search for specific author
Created by: Heather Braum

----------

Group: Administrative Reports
     Catalog-admin

Created on: 2013-08-09 18:59:11
Modified on: 2015-08-16 20:48:33
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>'), biblio.title, biblio.author, CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',biblio.title,'&sort_by=title_az\" target="_blank">',biblio.title,'</a>') as "title search", t.publishercode, t.pages, t.size, t.publicationyear FROM biblio LEFT JOIN items USING(biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE biblio.author LIKE <<enter author>> GROUP BY biblio.biblionumber HAVING count(items.itemnumber) > 0 ORDER BY biblio.title ASC LIMIT 1000



