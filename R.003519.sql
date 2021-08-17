/*
R.003519

----------

Name: sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-06-11 09:57:11
Modified on: 2021-08-07 23:35:34
Date last run: 2021-08-07 23:36:08

----------

Public: 0
Expiry: 300

----------

Setup for 942 cleanup - item type = NVIDEO


----------
*/

SELECT
  biblioitems.biblionumber,
  biblioitems.agerestriction,
  Group_Concat(DISTINCT items.permanent_location) AS
  Group_Concat_permanent_location,
  biblioitems.itemtype,
  Group_Concat(DISTINCT items.itype) AS Group_Concat_itype,
  biblioitems.cn_class,
  Group_Concat(DISTINCT items.ccode) AS Group_Concat_ccode
FROM
  biblioitems LEFT JOIN
  items ON items.biblioitemnumber = biblioitems.biblioitemnumber
WHERE
  biblioitems.itemtype IS NULL
GROUP BY
  biblioitems.biblionumber,
  biblioitems.agerestriction,
  biblioitems.itemtype,
  biblioitems.cn_class
HAVING
  Group_Concat(DISTINCT items.itype) = 'EQUIPMENT'
ORDER BY
  Group_Concat_ccode



