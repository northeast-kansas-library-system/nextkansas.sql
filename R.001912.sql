/*
R.001912

----------

Name: Null report -- Missing Shelving Location all
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Items-admin

Created on: 2013-06-16 15:02:19
Modified on: 2013-06-16 15:02:19
Date last run: 2020-10-27 11:13:05

----------

Public: 0
Expiry: 300

----------

Where shelving location is NULL

----------
*/

SELECT items.homebranch,items.barcode,items.dateaccessioned,items.ccode,items.itemcallnumber,items.itype,biblio.author,biblio.title FROM items JOIN biblio USING(biblionumber) WHERE items.location IS NULL OR items.location='XXX' order by items.homebranch



