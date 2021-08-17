/*
R.002664

----------

Name: Collection Switching from New Itype
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2016-02-08 11:49:27
Modified on: 2016-02-08 15:20:36
Date last run: 2021-08-02 08:11:49

----------

Public: 0
Expiry: 0

----------

copy the barcodes that return to the batch item editor. 

1) This report is set to return 999 items (the batch item editor limit). If you have more than that, you'll need to run this report multiple times. 

2) If you are using multiple versions New Item types (ex., new book and new movie), you'll need to run this report multiple times. 

----------
*/

SELECT barcode from items where homebranch=<<choose library|branches>> and itype=<<choose item type|itemtypes>> and dateaccessioned < <<choose latest date items added|date>> LIMIT 4000



