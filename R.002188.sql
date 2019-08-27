/*
R.002188

----------

Name: Top 100 Circing Items
Created by: Heather Braum

----------

Group: Administrative Reports
     Circ Stats-admin

Created on: 2014-02-07 11:37:56
Modified on: 2015-11-18 13:07:10
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT items.barcode, items.itemcallnumber, CONCAT( '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>' ) as 'Link to Record', biblio.title, t.publicationyear as 'Copyright', items.dateaccessioned as 'Accessioned', items.itype, items.ccode, items.issues, items.renewals,(IFNULL(items.issues,0)+IFNULL(items.renewals,0)) as
Total_Circ,items.datelastborrowed,items.itemlost,items.onloan,items.damaged,items.itemnotes FROM items LEFT JOIN biblio USING(biblionumber) LEFT JOIN biblioitems t USING(biblionumber)
ORDER BY Total_Circ DESC LIMIT 100



