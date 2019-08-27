/*
R.001885

----------

Name: Author Search on Specific publisher
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2013-05-24 22:22:11
Modified on: 2013-06-17 00:39:35
Date last run: -

----------

Public: 0
Expiry: 0

----------

Lists authors, and bib record counts, limited by a publisher code (probably use % sign around publisher)

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=au&q=',biblio.author,'&sort_by=title_az\" target="_blank">',biblio.author,'</a>') AS "Author Search", count(biblio.biblionumber) 
FROM biblio
LEFT JOIN biblioitems 
USING(biblionumber) 
WHERE biblioitems.publishercode LIKE <<publishercode>> 
GROUP BY biblio.author
ORDER BY biblio.author 
LIMIT 1000



