/*
R.002321

----------

Name: Searching for Duplicate Records
Created by: Heather Braum

----------

Group: Administrative Reports
     Duplicate Records-admin

Created on: 2014-08-14 22:48:16
Modified on: 2015-08-16 20:59:47
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\" target="_blank">',b.title,'</a>') AS "Title Search", CONCAT(trim(b.title)), GROUP_CONCAT(DISTINCT b.biblionumber SEPARATOR ', ') as numbers, GROUP_CONCAT(DISTINCT t.publicationyear SEPARATOR ', ') as copyright, GROUP_CONCAT(DISTINCT b.author SEPARATOR ', ') as author, GROUP_CONCAT(DISTINCT i.ccode SEPARATOR ', ') as ccode, count(DISTINCT b.biblionumber) FROM biblio b LEFT JOIN items i USING(biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE (i.ccode NOT IN ('ERESOURCE','DLVIDEO','DLAUDIO','DLBOOK','DLMUSIC'))
GROUP BY CONCAT(trim(b.title)) HAVING count(DISTINCT b.biblionumber) > 1



