/*
R.003644

----------

Name: ADMINREPORT - Can a variable be used in a SELECT statement
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-01-26 14:50:32
Modified on: 2022-01-26 14:50:32
Date last run: 2022-01-26 14:50:41

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  <<Enter barcode number>> AS BARCODE,
  items.itemnumber,
  items.barcode
FROM
  items
WHERE
  items.barcode = <<Enter barcode number>>

























