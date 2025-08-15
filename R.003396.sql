/*
R.003396

----------

Name: GHW - 942H ADMINREPORT - ASC
Created by: George Williams

----------

Group: -
     -

Created on: 2021-01-07 16:28:26
Modified on: 2024-01-24 21:19:38
Date last run: 2024-06-18 14:19:44

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat('https://staff.nextkansas.org/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblioitems.biblionumber) AS RAW_LINK,
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
  itemccode.Group_Concat_ccode = 'FICTION'
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

























