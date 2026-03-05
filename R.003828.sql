/*
R.003828

----------

Name: GHW - Basic item type list
Created by: George Williams

----------

Group: -
     -

Created on: 2024-04-11 16:25:11
Modified on: 2024-07-22 01:04:22
Date last run: 2025-05-06 14:08:03

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  itemtypes.description AS ITEM_TYPE_DESCRIPTION,
  itemtypes.itemtype AS ITEM_TYPE_CODE
FROM
  itemtypes
ORDER BY
  ITEM_TYPE_DESCRIPTION
LIMIT 1000

























