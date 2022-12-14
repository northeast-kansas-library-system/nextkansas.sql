/*
R.003678

----------

Name: unknown
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-11-16 20:07:10
Modified on: 2022-11-16 20:07:10
Date last run: 2022-11-16 20:18:48

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.barcode,
  items.homebranch
FROM
  items
WHERE
  items.barcode LIKE Concat(<<Enter barcode>>, '%')

























