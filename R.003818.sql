/*
R.003818

----------

Name: Bibliographic records with a null 'biblioitems.itemtype'
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-28 15:26:21
Modified on: 2024-03-28 15:26:21
Date last run: 2024-03-28 16:43:13

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblioitems.biblionumber,
  biblioitems.itemtype,
  Group_Concat(DISTINCT items.itype) AS Group_Concat_itype
FROM
  biblioitems LEFT JOIN
  items ON items.biblioitemnumber = biblioitems.biblioitemnumber
WHERE
  biblioitems.itemtype IS NULL
GROUP BY
  biblioitems.biblionumber,
  biblioitems.itemtype

























