/*
R.002877

----------

Name: GHW - lost and checked out
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2017-01-05 15:14:59
Modified on: 2017-01-05 15:15:39
Date last run: 2017-10-23 08:47:52

----------

Public: 0
Expiry: 0

----------

Report for GHW 2017.01.05


----------
*/

SELECT
  authorised_values.lib,
  items.itemnumber,
  items.homebranch,
  items.barcode,
  items.itemlost_on,
  items.onloan
FROM
  items LEFT JOIN
  authorised_values
    ON items.itemlost = authorised_values.authorised_value
WHERE
  items.itemlost <> 0 AND
  items.onloan IS NOT NULL AND
  authorised_values.category = 'LOST'
GROUP BY
  authorised_values.lib, items.itemnumber, items.homebranch, items.barcode,
  items.itemlost_on, items.onloan
ORDER BY
  authorised_values.lib,
  items.homebranch,
  items.itemlost_on




