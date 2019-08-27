/*
R.002340

----------

Name: Items Added in 2013-2014, Total Circ
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Collection Statistics

Created on: 2014-08-26 07:20:57
Modified on: 2014-08-26 07:23:20
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT i.ccode, i.location, (IFNULL(i.issues,0)+IFNULL(i.renewals,0)) as Total_Circ, count(i.itemnumber) FROM items i WHERE i.homebranch=<<branch|branches>> AND year(i.dateaccessioned) IN ('2013','2014') GROUP BY i.ccode,i.location,Total_Circ



