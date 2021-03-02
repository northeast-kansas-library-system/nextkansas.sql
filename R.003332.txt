/*
R.003332

----------

Name: GHW - ADMINREPORT permanent location fix
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-06-10 16:50:44
Modified on: 2020-06-11 16:20:19
Date last run: 2020-06-11 16:20:30

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  items.itemnumber,
  items.biblionumber,
  items.barcode,
  items.permanent_location,
  items.location
FROM
  items
WHERE
  (items.permanent_location IS NULL OR
      items.permanent_location = "")
GROUP BY
  items.itemnumber,
  items.biblionumber,
  items.barcode,
  items.permanent_location,
  items.location



