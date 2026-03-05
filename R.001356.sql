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
Date last run: 2026-01-14 14:31:38

----------

Public: 0
Expiry: 0

----------

Shows you your short barcodes (less than 13 digits) or blank barcodes. Can edit barcodes directly from the report. Choose your branch to run.

HB_Monthly

----------
*/



select i.itemnumber, i.dateaccessioned, b.title, i.ccode, i.itype, i.itemcallnumber, i.barcode, CONCAT(''"edit item"'') as "edit barcode" from biblio b left join items i using (biblionumber) where i.notforloan &lt;&gt;'-1' AND i.homebranch=&lt;&gt; AND (i.barcode IS NULL OR LENGTH(i.barcode) &lt; 13 OR i.barcode LIKE 'eudora%') ORDER BY i.ccode, i.itemcallnumber

























