/*
R.000429

----------

Name: Local Holds/Walkin Report (with acquisition date)
Created by: -

----------

Group: Catalog Records and Items
     Local Hold - Walkins

Created on: 2009-04-19 10:05:48
Modified on: 2017-09-19 12:43:47
Date last run: 2021-03-04 15:15:26

----------

Public: 0
Expiry: 0

----------

Enhanced - Run, select branch  to get a list of items with restricted item types.

----------
*/

SELECT i.homebranch, b.biblionumber, b.title, i.itype, i.ccode, i.dateaccessioned, i.itemcallnumber, i.barcode, t.publicationyear, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch LIKE <<Choose your branch|LBRANCH>> AND i.itype IN ('LOCALHOLD','LOCALHOLD1','LOCALHOLD2','WALKIN','WALKIN1','WALKIN2') ORDER by i.dateaccessioned ASC



