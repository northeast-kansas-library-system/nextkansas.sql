/*
R.003326

----------

Name: GHW - 942e phase 4
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-05-09 21:22:43
Modified on: 2021-04-02 17:19:20
Date last run: 2021-05-27 21:33:04

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    biblio.subtitle, 
    biblioitems.number,
    biblio.part_name
  ) AS FULL_TITLE,
  locs.lib AS BIB_LOCATION,
  itypess.description AS BIB_ITYPE,
  ccodes.lib AS CCODE,
  Date_Format(biblio.datecreated, "%Y.%m.%d") AS DATE_ADDED,
  biblio.biblionumber,
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio.biblionumber, 
    '\" target="_blank">Go to title</a>'
  ) AS LINK_TO_TITLE,
  Query1.COUNT,
  Query1.Group_Concat_permanent_location
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
      biblioitems.cn_class INNER JOIN
  (SELECT
      items.biblionumber,
      Count(DISTINCT items.permanent_location) AS COUNT,
      Group_Concat(DISTINCT items.permanent_location) AS
      Group_Concat_permanent_location
    FROM
      items
    GROUP BY
      items.biblionumber
    HAVING
      Count(DISTINCT items.permanent_location) = '1') Query1 ON
      Query1.biblionumber = biblio.biblionumber
WHERE
  locs.lib IS NULL AND
  Query1.Group_Concat_permanent_location LIKE "%ADULT%"
GROUP BY
  biblio.biblionumber,
  Query1.COUNT,
  Query1.Group_Concat_permanent_location
LIMIT 500



