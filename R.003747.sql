/*
R.003747

----------

Name: GHW - Sample report for CKLS 1
Created by: George Williams

----------

Group: -
     -

Created on: 2023-08-04 14:05:53
Modified on: 2023-08-11 11:19:48
Date last run: 2023-08-11 11:19:51

----------

Public: 0
Expiry: 300

----------

Report shows a count of items added in the previous calendar month grouped by home library and collection code.

Previous calendar month is fixed.

----------
*/



Select
  items.homebranch,
  items.ccode,
  Count(items.itemnumber) As Count_itemnumber
From
  items
Where
  Year(items.dateaccessioned) = Year(Now() - Interval 1 Month) And
  Month(items.dateaccessioned) = Month(Now() - Interval 1 Month)
Group By
  items.homebranch,
  items.ccode
WITH Rollup

























