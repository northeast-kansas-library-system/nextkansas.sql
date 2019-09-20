/*
R.001398

----------

Name: Collection Codes to Fix
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2012-05-14 21:50:49
Modified on: 2015-08-16 19:41:45
Date last run: 2019-09-18 10:32:19

----------

Public: 0
Expiry: 0

----------

Missing/Null, or XXX/Unclassified Ccode -- Enhanced -- Choose branch from the dropdown. Can edit items directly linked from this report. (On Reports Webpages, 5/14/12) #cleanup

----------
*/

SELECT i.dateaccessioned,b.title, b.author,t.publicationyear, i.location,i.itype,i.itemcallnumber,i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit barcode" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=<<Pick your branch|branches>> AND (i.ccode = 'XXX' OR i.ccode IS NULL)
ORDER BY i.dateaccessioned desc



