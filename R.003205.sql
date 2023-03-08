/*
R.003205

----------

Name: McNaughton
Created by: HCC DIRECTOR

----------

Group: Circulation
     -

Created on: 2019-05-22 13:44:28
Modified on: 2019-05-22 13:44:28
Date last run: 2022-12-21 13:28:44

----------

Public: 0
Expiry: 29

----------



----------
*/



SELECT  items.barcode,items.issues,items.reserves,items.ccode FROM borrowers LEFT JOIN statistics on (statistics.borrowernumber=borrowers.borrowernumber) LEFT JOIN items on (items.itemnumber = statistics.itemnumber) LEFT JOIN biblioitems on (biblioitems.biblioitemnumber = items.biblioitemnumber)   WHERE items.itype='BOOK'

























