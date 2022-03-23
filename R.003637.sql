/*
R.003637

----------

Name: 2022-cleanup
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-01-05 00:03:42
Modified on: 2022-01-07 08:41:26
Date last run: 2022-01-14 14:14:39

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
WHERE
  items.itype = <<Choose item type|itemtypes>>

























