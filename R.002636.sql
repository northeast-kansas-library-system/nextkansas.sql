/*
R.002636

----------

Name: Recently Returned
Created by: Heather Braum

----------

Group: Circulation
     -

Created on: 2015-11-23 12:09:25
Modified on: 2015-11-23 12:09:50
Date last run: 2018-01-09 13:11:54

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT b.title,b.biblionumber,SUBSTRING_INDEX(bi.isbn, ' ', 1) AS isbn
FROM old_issues i
LEFT JOIN items i2 USING (itemnumber)
LEFT JOIN biblio b ON (i2.biblionumber=b.biblionumber)
LEFT JOIN biblioitems bi ON (b.biblionumber=bi.biblionumber)
WHERE i.returndate BETWEEN Now() - INTERVAL 1 DAY AND Now() AND bi.isbn IS NOT NULL
ORDER BY i.returndate DESC
LIMIT 20



