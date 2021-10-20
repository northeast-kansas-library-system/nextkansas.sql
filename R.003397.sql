/*
R.003397

----------

Name: GHW - 942H ADMINREPORT - DESC
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-01-08 11:16:37
Modified on: 2021-01-09 22:22:30
Date last run: 2021-07-14 09:37:28

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblioitems.biblionumber,
  biblio.author,
  biblio.title,
  biblio.subtitle,
  biblio.medium,
  biblioitems.itemtype,
  biblioitems.cn_class,
  itemccode.Group_Concat_ccode
FROM
  biblio JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber JOIN
  (SELECT
      items.biblionumber,
      GROUP_CONCAT(DISTINCT items.ccode ORDER BY items.ccode) AS
      Group_Concat_ccode
    FROM
      items
    GROUP BY
      items.biblionumber) itemccode ON itemccode.biblionumber =
      biblioitems.biblionumber
WHERE
  biblioitems.cn_class IS NULL AND
  itemccode.Group_Concat_ccode = 'PAPERBACK'
GROUP BY
  biblioitems.biblionumber,
  biblio.author,
  biblio.title,
  biblio.subtitle,
  biblio.medium,
  biblioitems.itemtype,
  biblioitems.cn_class,
  itemccode.Group_Concat_ccode
ORDER BY
  biblioitems.biblionumber DESC
LIMIT 1000

























