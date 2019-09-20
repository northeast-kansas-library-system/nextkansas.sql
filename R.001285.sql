/*
R.001285

----------

Name: Null Report - Missing Collection Codes all
Created by: -

----------

Group: Administrative Reports
     Fix Items-admin

Created on: 2012-01-03 10:55:37
Modified on: 2013-06-16 14:58:20
Date last run: 2019-09-04 11:22:25

----------

Public: 0
Expiry: 0

----------

Monthly report for all missing CCodes.

----------
*/

SELECT items.homebranch,items.barcode,items.dateaccessioned,items.ccode,items.itemcallnumber,items.itype,biblio.author,biblio.title FROM items JOIN biblio USING(biblionumber) WHERE items.ccode IS NULL OR items.ccode='XXX' order by items.homebranch



