/*
R.003744

----------

Name: Wipe away withdrawns
Created by: George Williams

----------

Group: -
     -

Created on: 2023-07-26 16:10:43
Modified on: 2023-07-26 17:54:41
Date last run: 2023-07-26 17:57:55

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.itemnumber,
  Concat('-', items.barcode, '-') AS BARCODE,
  items.withdrawn,
  items.withdrawn_on,
  items.onloan
FROM
  items
WHERE
  items.withdrawn = 4
ORDER BY
  items.onloan

























