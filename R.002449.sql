/*
R.002449

----------

Name: unknown
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-01-24 15:20:17
Modified on: 2015-12-09 15:27:50
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',biblio.title,'&sort_by=title_az\" target="_blank">',biblio.title,'</a>') AS "Title Search" FROM biblio  WHERE biblionumber IN (SELECT biblionumber FROM biblioitems WHERE pages LIKE '[ ] p.%') AND biblionumber NOT IN (SELECT biblio.biblionumber FROM biblio LEFT JOIN items USING(biblionumber) WHERE items.itemnumber IS NULL)



