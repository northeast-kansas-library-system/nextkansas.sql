/*
R.000536

----------

Name: New acquisitions for a specific month
Created by: -

----------

Group: Catalog Records and Items
     New Materials

Created on: 2009-05-04 15:06:32
Modified on: 2015-08-17 15:47:14
Date last run: 2020-08-14 07:04:09

----------

Public: 0
Expiry: 0

----------

Enter numeric month and year for the month you want to look at. 

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>') AS "Link to Record",  items.dateaccessioned, biblio.author, biblio.title, items.itemcallnumber, items.ccode, items.itype, items.location, items.barcode, items.price, items.replacementprice, items.timestamp FROM items JOIN biblio USING(biblionumber) WHERE items.homebranch=<<Pick your branch|branches>> AND month(items.dateaccessioned) = <<Choose month|Month>> AND year (items.dateaccessioned) = <<Choose year|Year>>
ORDER BY biblio.biblionumber



