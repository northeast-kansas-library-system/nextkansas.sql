/*
R.003343

----------

Name: GHW - Get itemnumber by Array
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-13 15:39:10
Modified on: 2020-08-13 16:01:52
Date last run: 2020-08-13 16:03:48

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.itemnumber
FROM
  items
WHERE
  items.barcode IN (<<Enter item barcode numbers in quotes and separated by commas>>)

























