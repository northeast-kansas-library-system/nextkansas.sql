/*
R.003550

----------

Name: GHW - Biblio reconciliation Last months adds
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-08-09 16:23:24
Modified on: 2021-08-09 16:48:22
Date last run: 2021-08-17 10:50:58

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  biblio.biblionumber,
  biblio.datecreated,
  biblio.author,
  biblio.title,
  biblioitems.agerestriction,
  GROUP_CONCAT(
    DISTINCT 
    items.permanent_location 
    ORDER BY items.permanent_location 
    SEPARATOR " / "
  ) AS "Item permanent location", 
  biblioitems.itemtype, 
  GROUP_CONCAT(
    DISTINCT items.itype 
    ORDER BY items.itype 
    SEPARATOR " / "
  ) AS "Item itype",
  biblioitems.cn_class,
  GROUP_CONCAT(
    DISTINCT items.ccode 
    ORDER BY items.ccode SEPARATOR " / "
  ) AS "Item CCODE"
FROM
  biblio JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber JOIN
  items ON items.biblionumber = biblio.biblionumber
WHERE
  Year(biblio.datecreated) = Year(Now() - INTERVAL 1 MONTH) AND
  Month(biblio.datecreated) = Month(Now() - INTERVAL 1 MONTH) AND
  Coalesce(biblioitems.agerestriction, "-") LIKE "%" AND
  Coalesce(biblioitems.itemtype, "-") LIKE "%" AND
  Coalesce(biblioitems.cn_class, "-") LIKE "%"
GROUP BY
  biblio.biblionumber,
  biblioitems.biblionumber,
  items.biblionumber
ORDER BY
  biblio.biblionumber DESC



