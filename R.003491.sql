/*
R.003491

----------

Name: GHW - List of item types
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-04-05 22:44:57
Modified on: 2021-04-05 22:44:57
Date last run: 2021-04-08 14:08:24

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



