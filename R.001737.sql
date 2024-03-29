/*
R.001737

----------

Name: Doniphan Restricted Item Types
Created by: DONITROY TECH

----------

Group:  Doniphan County
     -

Created on: 2013-02-01 11:16:07
Modified on: 2021-08-16 20:40:25
Date last run: 2022-09-23 15:09:10

----------

Public: 0
Expiry: 0

----------

Special report for Doniphan County that includes all their branches and items with Local Hold or Walkin Item Types. 

----------
*/



SELECT i.homebranch, b.biblionumber, b.title, i.itype, i.ccode, i.dateaccessioned, i.itemcallnumber, i.barcode, t.publicationyear, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber)  LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch IN ('DONIELWD','DONIHIGH','DONITROY','DONIWATH') AND i.itype IN ('LOCALHOLD','LOCALHOLD1','LOCALHOLD2','WALKIN','WALKIN1','WALKIN2') ORDER by i.ccode ASC, i.dateaccessioned ASC limit 2000

























