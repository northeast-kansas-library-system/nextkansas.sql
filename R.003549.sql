/*
R.003549

----------

Name: 942e - Blank or way off
Created by: George Williams

----------

Group: -
     -

Created on: 2021-08-06 11:01:19
Modified on: 2024-07-08 14:53:37
Date last run: 2026-03-03 10:21:29

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblioitems.biblionumber
FROM
  biblioitems
WHERE
  ((biblioitems.agerestriction LIKE "" OR
      biblioitems.agerestriction IS NULL)) OR
  ((biblioitems.itemtype LIKE "" OR
      biblioitems.itemtype IS NULL)) OR
  ((biblioitems.cn_class LIKE "" OR
      biblioitems.cn_class IS NULL))
GROUP BY
  biblioitems.biblionumber
ORDER BY
  biblioitems.biblionumber

























