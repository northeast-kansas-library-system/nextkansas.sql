/*
R.001946

----------

Name: Extra Large MARC records (over 9999 in length)
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2013-07-17 16:56:45
Modified on: 2018-07-01 22:38:26
Date last run: 2018-07-01 22:38:43

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblio_metadata.biblionumber,
       biblio.title,
       Length(biblio_metadata.metadata)
FROM   biblio_metadata
       LEFT JOIN items using(biblionumber)
       LEFT JOIN biblio using(biblionumber)
WHERE  Length(biblio_metadata.metadata) > 99999
GROUP  BY biblio_metadata.biblionumber
HAVING Count(items.itemnumber) > 0  



