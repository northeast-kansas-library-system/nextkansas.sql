/*
R.002049

----------

Name: Printed list of books from a list
Created by: Heather Braum

----------

Group: Lists Module
     -

Created on: 2013-10-14 13:16:08
Modified on: 2019-07-17 16:33:54
Date last run: 2019-07-17 16:27:09

----------

Public: 0
Expiry: 0

----------

<p><span style="background-color: darkred; color: white">Scheduled for deletion on August 31, 2019</p>

<p><span style="background-color: black; color: white">Is being replaced by report 3227</p>

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>') AS "bib number", items.itemcallnumber, biblio.title, biblio.author, items.ccode, items.location,items.barcode, items.homebranch FROM virtualshelfcontents LEFT JOIN biblio USING(biblionumber) LEFT JOIN items USING(biblionumber) WHERE virtualshelfcontents.shelfnumber=<<enter list number>> GROUP BY biblio.biblionumber ORDER BY biblio.title, items.itemcallnumber



