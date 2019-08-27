/*
R.001558

----------

Name: Large Print Report for Book Club
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2012-09-24 11:42:24
Modified on: 2013-10-25 10:19:47
Date last run: 2017-09-11 10:08:29

----------

Public: 0
Expiry: 0

----------

Locates records with 5 or more Large Print items attached. 

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"record link"'</a>') AS "Record Link", b.title, b.author, count(i.itemnumber) from biblio b JOIN items i USING(biblionumber) WHERE i.ccode='LARGEPRINT' group by b.biblionumber HAVING count(i.itemnumber) > 4 ORDER BY b.author ASC



