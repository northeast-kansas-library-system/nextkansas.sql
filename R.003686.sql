/*
R.003686

----------

Name: GHW - test
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-05 15:16:14
Modified on: 2022-12-05 15:16:14
Date last run: 2022-12-05 15:16:40

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio.author,
  Concat_Ws(" ", biblio.title, biblio.subtitle, biblioitems.number,
  biblio.part_name) AS FULL_TITLE,
  locs.lib AS BIB_LOCATION,
  itypess.description AS BIB_ITYPE,
  ccodes.lib AS CCODE,
  Date_Format(biblio.datecreated, "%Y.%m.%d") AS DATE_ADDED,
  biblio.biblionumber,
  Concat('<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Go to title</a>') AS LINK_TO_TITLE,
  bib_locations.COUNT,
  bib_locations.Group_Concat_permanent_location
FROM
  biblio JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      biblioitems.agerestriction LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypess ON itypess.itemtype = biblioitems.itemtype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      biblioitems.cn_class JOIN
  (SELECT
      items.biblionumber,
      Count(DISTINCT items.permanent_location) AS COUNT,
      Group_Concat(DISTINCT If(items.permanent_location LIKE '%AD%', 'L_AD',
      If(items.permanent_location LIKE '%JU%', 'L_JU',
      If(items.permanent_location LIKE '%YA%', 'L_YA', 'x')))) AS
      Group_Concat_permanent_location
    FROM
      items
    GROUP BY
      items.biblionumber
    HAVING
      Count(DISTINCT items.permanent_location) = '1') bib_locations ON
      bib_locations.biblionumber = biblio.biblionumber
WHERE
  (locs.lib NOT LIKE '%AD%' AND
    locs.lib NOT LIKE '%JU%' AND
    bib_locations.Group_Concat_permanent_location LIKE '%AD%') OR
  ((locs.lib IS NULL OR
      locs.lib = "") AND
    bib_locations.Group_Concat_permanent_location LIKE '%AD%')
GROUP BY
  biblio.biblionumber,
  bib_locations.COUNT,
  bib_locations.Group_Concat_permanent_location
LIMIT 500

























