/*
R.000425

----------

Name: ALL LOCALHOLD & WALKIN types in catalog
Created by: -

----------

Group: Administrative Reports
     Local Holds - Walkin-admin

Created on: 2009-04-14 16:21:25
Modified on: 2015-06-30 14:30:38
Date last run: 2019-07-31 09:30:51

----------

Public: 0
Expiry: 0

----------

All Libraries

----------
*/

SELECT items.homebranch, items.itype,items.ccode,items.itemcallnumber,items.barcode,items.dateaccessioned,biblio.title,biblioitems.publicationyear FROM items LEFT JOIN biblio USING(biblionumber) LEFT JOIN biblioitems USING(biblionumber) WHERE items.itype LIKE 'LOCALHOLD%' OR items.itype LIKE 'WALKIN%' ORDER BY items.homebranch asc, items.itype, items.ccode, items.dateaccessioned



