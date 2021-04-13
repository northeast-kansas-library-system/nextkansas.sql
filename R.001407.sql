/*
R.001407

----------

Name: Not For Loan Status
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2012-05-14 22:30:34
Modified on: 2015-08-16 20:06:31
Date last run: 2021-03-02 12:13:36

----------

Public: 0
Expiry: 0

----------

Items set to Not Available. Enhanced -- Choose Branch. Can edit items directly linked from this report. (On Reports Webpages, 5/14/12) #notforloan

----------
*/

SELECT authorised_values.lib, items.dateaccessioned,biblio.title, biblio.author,t.publicationyear, items.ccode, items.itype, items.location, items.itemcallnumber, items.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',biblio.biblionumber,'&itemnumber=',items.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit barcode" FROM items LEFT JOIN biblioitems t USING(biblionumber) LEFT JOIN biblio USING (biblionumber) LEFT JOIN authorised_values ON (items.notforloan=authorised_values.authorised_value) WHERE items.homebranch=<<Pick your branch|branches>> AND items.notforloan !=0 AND authorised_values.category='NOT_LOAN' ORDER BY authorised_values.lib, items.ccode, items.itemcallnumber



