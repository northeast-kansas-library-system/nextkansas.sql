/*
R.003763

----------

Name: 942c - blank or way off
Created by: George Williams

----------

Group: -
     -

Created on: 2023-09-28 10:49:25
Modified on: 2023-09-28 10:49:25
Date last run: 2023-09-28 10:49:35

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblioitems.biblionumber,
  biblioitems.itemtype
FROM
  biblioitems
WHERE
  (biblioitems.itemtype LIKE "" OR
    biblioitems.itemtype IS NULL OR
    biblioitems.itemtype NOT IN (SELECT
        itemtypes.itemtype
      FROM
        itemtypes))
GROUP BY
  biblioitems.biblionumber,
  biblioitems.itemtype
ORDER BY
  biblioitems.biblionumber

























