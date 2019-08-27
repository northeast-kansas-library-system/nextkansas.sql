/*
R.002134

----------

Name: Holding and Homebranch same, barcode list
Created by: Heather Braum

----------

Group: Catalog Records and Items
     -

Created on: 2013-12-20 14:35:12
Modified on: 2014-01-03 22:05:19
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT barcode FROM items WHERE holdingbranch=<<choose branch|branches>> AND homebranch=<<choose branch|branches>>



