/*
R.003396

----------

Name: GHW - 942H ADMINREPORT - ASC
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-01-07 16:28:26
Modified on: 2021-01-08 11:16:54
Date last run: 2021-05-25 21:33:30

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
  itemccode.Group_Concat_ccode = 'NONFICTION'
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
  biblioitems.biblionumber ASC
LIMIT 1000

























