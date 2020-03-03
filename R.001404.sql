/*
R.001404

----------

Name: Shelving Locations to fix
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2012-05-14 22:13:27
Modified on: 2015-08-16 19:39:23
Date last run: 2020-02-12 17:58:14

----------

Public: 0
Expiry: 0

----------

Missing/Null Shelving Locations or NonStandard Shelving Locations (NOT ADULT, YOUNGADULT, or CHILDRENS).  -- Enhanced -- Choose branch from the dropdowns. Can edit items directly linked from this report. (On Reports Webpages, 5/14/12) #cleanup

----------
*/

SELECT i.dateaccessioned,b.title, b.author,t.publicationyear, i.location, i.ccode,i.itype,i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit barcode" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber)
WHERE i.homebranch=<<Pick your branch|branches>> AND (i.location IS NULL OR i.location NOT IN ('ADULT','CHILDRENS','YOUNGADULT')) ORDER BY i.dateaccessioned desc



