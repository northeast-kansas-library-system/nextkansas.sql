/*
R.003748

----------

Name: GHW - Sample report for CKLS 2
Created by: George Williams

----------

Group: -
     -

Created on: 2023-08-04 14:08:25
Modified on: 2023-08-11 11:22:01
Date last run: 2023-08-11 11:22:11

----------

Public: 0
Expiry: 300

----------

Report shows a count of items added in the year and month specified grouped by home library and collection code. 

Year and month are controlled by authorised values.

----------
*/



Select
  items.homebranch,
  items.ccode,
  Count(items.itemnumber) As Count_itemnumber
From
  items
Where
  Year(items.dateaccessioned) = <> And
  Month(items.dateaccessioned) = <>
Group By
  items.homebranch,
  items.ccode
WITH Rollup

























