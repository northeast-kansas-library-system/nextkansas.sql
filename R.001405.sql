/*
R.001405

----------

Name: Missing Call Number
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2012-05-14 22:18:13
Modified on: 2015-08-16 19:39:04
Date last run: 2021-08-04 13:48:16

----------

Public: 0
Expiry: 0

----------

Missing Item Call Number -- Enhanced -- Choose branch. Can edit items directly linked from this report. (On Reports Webpages, 5/14/12) #cleanup

----------
*/

SELECT i.dateaccessioned,b.title, b.author,t.publicationyear, i.location, i.ccode,i.itype,i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=<<Pick your branch|branches>> AND i.itemcallnumber IS NULL ORDER BY i.dateaccessioned desc



