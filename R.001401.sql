/*
R.001401

----------

Name: Item Types to Fix
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2012-05-14 22:01:56
Modified on: 2018-09-20 13:55:31
Date last run: 2019-09-18 10:32:43

----------

Public: 0
Expiry: 0

----------

Missing/Null, or XXX/Unclassified Item Types -- Enhanced -- Choose branch from the dropdown. Can edit items directly linked from this report. (On Reports Webpages, 5/14/12) #cleanup

HB_Monthly

----------
*/

SELECT i.dateaccessioned,b.title, b.author,t.publicationyear, i.ccode,i.location,i.itemcallnumber,i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit barcode" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=<<Pick your branch|branches>> AND (i.itype = 'XXX' OR i.itype IS NULL) ORDER BY i.dateaccessioned desc



