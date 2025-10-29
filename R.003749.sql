/*
R.003749

----------

Name: GHW - Sample report for CKLS 3
Created by: George Williams

----------

Group: -
     -

Created on: 2023-08-04 14:13:12
Modified on: 2023-08-11 11:30:45
Date last run: 2023-08-11 11:28:06

----------

Public: 0
Expiry: 300

----------

Report shows a count of items added during the date range specified grouped by home library and collection code. 

The date range is controlled by a between statement with runtime parameters.

----------
*/



Select
  items.homebranch,
  items.ccode,
  Count(items.itemnumber) As Count_itemnumber
From
  items
Where
  items.dateaccessioned BETWEEN <> AND (<> + interval 1 day)
Group By
  items.homebranch,
  items.ccode
WITH rollup

























