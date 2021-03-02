/*
R.001356

----------

Name: Barcode Cleanup Report
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2012-04-20 14:27:57
Modified on: 2018-09-20 13:54:54
Date last run: 2021-01-11 14:25:22

----------

Public: 0
Expiry: 0

----------

Shows you your short barcodes (less than 13 digits) or blank barcodes. Can edit barcodes directly from the report. Choose your branch to run.

HB_Monthly

----------
*/

select i.itemnumber, i.dateaccessioned, b.title, i.ccode, i.itype, i.itemcallnumber, i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit barcode" from biblio b left join items i using (biblionumber) where i.notforloan <>'-1' AND i.homebranch=<<branch|branches>> AND (i.barcode IS NULL OR LENGTH(i.barcode) < 13 OR i.barcode LIKE 'eudora%') ORDER BY i.ccode, i.itemcallnumber



