/*
R.003761

----------

Name: Items with faulty item types
Created by: George Williams

----------

Group: -
     -

Created on: 2023-09-18 14:15:08
Modified on: 2023-09-18 14:15:08
Date last run: 2023-09-18 14:24:49

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.homebranch,
  items.barcode
FROM
  items
WHERE
  items.itype NOT IN (SELECT
      itemtypes.itemtype
    FROM
      itemtypes)

























