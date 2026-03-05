/*
R.001553

----------

Name: Deleted Items By Month
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeded Already

Created on: 2012-09-19 14:26:14
Modified on: 2015-05-19 11:42:48
Date last run: 2025-10-17 12:03:05

----------

Public: 0
Expiry: 0

----------

#special #weeding

----------
*/



SELECT MONTH(timestamp), YEAR(timestamp), count(&ast;) as count FROM deleteditems WHERE deleteditems.homebranch = &lt;&gt; GROUP BY MONTH(timestamp), YEAR(timestamp) ORDER BY YEAR(timestamp) DESC, MONTH(timestamp) DESC

























