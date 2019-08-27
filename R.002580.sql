/*
R.002580

----------

Name: Added and Deleted items for Specific Year for All Public Libraries
Created by: Heather Braum

----------

Group: Administrative Reports
     Collection Stats-admin

Created on: 2015-08-21 15:34:53
Modified on: 2015-08-21 15:36:19
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT branchcode, (SELECT count(*) FROM items WHERE homebranch=branches.branchcode) as "Current Collection Size", (SELECT count(*) FROM items WHERE items.homebranch=branches.branchcode AND year(dateaccessioned)=<<choose year|Year>>) as "New Items Added in Set Year", (SELECT count(*) FROM deleteditems WHERE deleteditems.homebranch=branches.branchcode AND year(timestamp)=<<choose year again|Year>>) as "Deleted Items in Set Year" FROM branches WHERE branchcode NOT IN ('PAOLA','LOUISBURG','DIGITAL','PHSHS','PHSES','PHSMS','PHAXTELL','PHWAC') LIMIT 50



