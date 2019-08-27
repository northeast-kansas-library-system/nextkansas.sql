/*
R.002192

----------

Name: Book on Cass and VHS weeding
Created by: Heather Braum

----------

Group: Administrative Reports
     Weeding-Admin

Created on: 2014-02-19 16:27:07
Modified on: 2015-08-16 20:29:15
Date last run: 2018-10-08 12:18:52

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">',b.biblionumber,'</a>') AS "bib number", i.homebranch, i.itemcallnumber, i.ccode, i.location, b.title,b.author,t.publicationyear as 'Copyright', i.dateaccessioned as 'Accessioned', i.itype, i.ccode, (IFNULL(i.issues,0)+IFNULL(i.renewals,0)) as Total_Circ, i.datelastborrowed,i.datelastseen, i.itemlost, i.onloan, i.damaged, i.itemnotes FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber)   WHERE i.ccode IN ('BOOKONCASS','VHS') ORDER BY i.ccode, i.dateaccessioned



