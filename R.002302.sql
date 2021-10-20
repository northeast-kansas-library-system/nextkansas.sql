/*
R.002302

----------

Name: Your library's lost items not at your library
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Status reports-lost, damaged

Created on: 2014-07-25 15:25:01
Modified on: 2015-08-16 20:55:02
Date last run: 2021-10-05 14:10:15

----------

Public: 0
Expiry: 0

----------

Shows your library's items marked lost that have a current location that is not your library. 

----------
*/



SELECT items.timestamp AS "Last System Change", items.datelastseen AS "Last Scanner Gun Date", biblio.title, biblio.author,biblioitems.publicationyear, items.holdingbranch, items.location, items.ccode,items.itype,items.itemcallnumber, items.itemnotes, items.barcode, items.replacementprice, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/moredetail.pl?itemnumber=',items.itemnumber,'&biblionumber=',biblio.biblionumber,'&bi=',biblioitems.biblioitemnumber,'#item',items.itemnumber,'\" target="_blank">'"item info"'</a>') AS "Item Info" FROM items LEFT JOIN biblio USING(biblionumber) LEFT JOIN biblioitems USING (biblionumber) LEFT JOIN authorised_values ON (items.itemlost=authorised_values.authorised_value) WHERE items.homebranch=<<Pick your branch|branches>> AND items.holdingbranch != <<pick your branch|branches>> AND items.itemlost != 0 AND authorised_values.category='LOST' ORDER BY items.timestamp ASC

























