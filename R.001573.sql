/*
R.001573

----------

Name: Identify Multiple Items of a Title
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeding Criteria

Created on: 2012-10-02 11:42:10
Modified on: 2016-06-09 10:33:43
Date last run: 2023-02-22 13:36:27

----------

Public: 0
Expiry: 0

----------

Identifies the records where your library has multiple copies of a title; includes barcodes, call numbers, shelving locations, and collection codes. 

----------
*/



SELECT CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">'"link to record"'</a>') as "link to record", biblio.title, biblio.author, count(itemnumber) as "total items", GROUP_CONCAT(items.barcode SEPARATOR '; ') as barcodes, GROUP_CONCAT(items.ccode SEPARATOR '; ') as ccodes, GROUP_CONCAT(items.location SEPARATOR '; ') as locations, GROUP_CONCAT(items.itemcallnumber SEPARATOR '; ') as callnumbers FROM biblio LEFT JOIN items USING(biblionumber) WHERE items.homebranch=<<choose library|branches>> AND (itype NOT IN ('MAGAZINE','NEWMAGAZINE','WALKIN') OR ccode <> 'MAGAZINE') GROUP BY items.biblionumber HAVING count(items.itemnumber) > 1 ORDER BY biblio.author


























