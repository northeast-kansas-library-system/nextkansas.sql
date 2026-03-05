/*
R.003830

----------

Name: Biblios with missing 942 data
Created by: George Williams

----------

Group: -
     -

Created on: 2024-05-03 10:10:09
Modified on: 2024-05-06 09:05:02
Date last run: 2024-08-28 08:32:27

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  '-' AS BIBLIO_NUMBER,
  'Needs permanent location' AS BIBLIO_NUMBER,
  '942$e' AS ELEMENT_FROM_ITEM_RECORD,
  '' AS CALL_NUMBERS,
  '' AS LINK
UNION
SELECT
  biblio.biblionumber AS BIBLIO_NUMBER,
  biblioitems.agerestriction AS MISSING_ELEMENT,
  Group_Concat(DISTINCT items.permanent_location) AS ELEMENT_FROM_ITEM_RECORD,
  Group_Concat(DISTINCT items.itemcallnumber) AS CALL_NUMBERS,
  Concat(
    '<a class="btn btn-default noprint" ',
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio.biblionumber,
    '\" target="_blank">Go to title</a>'club_template_enrollment_fields
  ) AS LINK_TO_TITLE
FROM
  biblio JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber JOIN
  items ON items.biblionumber = biblio.biblionumber
WHERE
  (biblioitems.agerestriction IS NULL OR
    biblioitems.agerestriction LIKE '')
GROUP BY
  biblio.biblionumber,
  biblioitems.agerestriction
UNION
SELECT
  '--' AS BIBLIO_NUMBER,
  'Needs Item type' AS BIBLIO_NUMBER,
  '942$c' AS ELEMENT_FROM_ITEM_RECORD,
  '' AS CALL_NUMBERS,
  '' AS LINK
UNION
SELECT
  biblio.biblionumber,
  biblioitems.itemtype,
  Group_Concat(DISTINCT items.itype) AS Group_Concat_itype,
  Group_Concat(DISTINCT items.itemcallnumber) AS CALL_NUMBERS,
  Concat('<a class="btn btn-default noprint" ',
  'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber,
  '\" target="_blank">Go to title</a>') AS LINK_TO_TITLE
FROM
  biblio JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber JOIN
  items ON items.biblionumber = biblio.biblionumber
WHERE
  (biblioitems.itemtype IS NULL OR
    biblioitems.itemtype = '')
GROUP BY
  biblio.biblionumber,
  biblioitems.itemtype
UNION
SELECT
  '---' AS BIBLIO_NUMBER,
  'Needs Collection code' AS BIBLIO_NUMBER,
  '942$h' AS ELEMENT_FROM_ITEM_RECORD,
  '' AS CALL_NUMBER,
  '' AS LINK
UNION
SELECT
  biblio.biblionumber,
  biblioitems.cn_class,
  Group_Concat(DISTINCT items.ccode) AS Group_Concat_ccode,
  Group_Concat(DISTINCT items.itemcallnumber) AS CALL_NUMBERS,
  Concat('<a class="btn btn-default noprint" ',
  'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber,
  '\" target="_blank">Go to title</a>') AS LINK_TO_TITLE
FROM
  biblio JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber JOIN
  items ON items.biblionumber = biblio.biblionumber
WHERE
  (biblioitems.cn_class IS NULL OR
    biblioitems.cn_class = '')
GROUP BY
  biblio.biblionumber,
  biblioitems.cn_class

























