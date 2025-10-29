/*
R.003391

----------

Name: GHW - Sandbox - ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2020-12-28 15:17:04
Modified on: 2024-01-30 16:50:54
Date last run: 2024-01-30 16:51:00

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  items.itemnumber,
  items.dateaccessioned
From
  items
WHERE 
items.dateaccessioned > '2024-01-30'- interval <> day

























