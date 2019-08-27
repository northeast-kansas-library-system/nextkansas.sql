/*
R.001887

----------

Name: Count of Records, per title
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2013-05-25 16:17:14
Modified on: 2013-06-17 00:52:48
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblio.title, count(biblio.biblionumber) FROM biblio LEFT JOIN items USING(biblionumber) GROUP by title HAVING count(items.itemnumber) > 0 ORDER BY title



