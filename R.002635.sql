/*
R.002635

----------

Name: Recently Checked Out
Created by: Heather Braum

----------

Group: Circulation
     Checked Out

Created on: 2015-11-23 12:07:57
Modified on: 2015-11-23 12:08:43
Date last run: 2018-11-30 16:03:27

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT b.title,b.biblionumber,SUBSTRING_INDEX(bi.isbn, ' ', 1) AS isbn
FROM issues i
LEFT JOIN items i2 USING (itemnumber)
LEFT JOIN biblio b ON (i2.biblionumber=b.biblionumber)
LEFT JOIN biblioitems bi ON (b.biblionumber=bi.biblionumber)
WHERE bi.isbn IS NOT NULL
ORDER BY i.issuedate DESC
LIMIT 20


