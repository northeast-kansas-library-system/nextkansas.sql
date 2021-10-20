/*
R.003395

----------

Name: GHW - Item type update - ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-01-01 12:02:56
Modified on: 2021-01-01 12:02:56
Date last run: 2021-01-01 18:16:08

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.itemnumber,
  items.itype
FROM
  items
WHERE  items.itype = <<itype>>

























