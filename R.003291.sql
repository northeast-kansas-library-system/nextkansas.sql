/*
R.003291

----------

Name: GHW - Authorised Values synchronization - borrower categories
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-12-30 11:46:03
Modified on: 2020-01-28 16:05:19
Date last run: 2021-06-08 13:50:20

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', LBORROWERCAT.category, '" target="_blank">Link to AV</a>') AS LINK,
  If(LBORROWERCAT.category IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBORROWERCAT.category) AS category,
  If(LBORROWERCAT.authorised_value IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBORROWERCAT.authorised_value) AS authorised_value,
  If(LBORROWERCAT.lib IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBORROWERCAT.lib) AS lib,
  If(PATCAT.categorycode IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", PATCAT.categorycode) AS categorycode,
  If(PATCAT.description IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", PATCAT.description) AS description
FROM
  (
    SELECT
      authorised_values.id,
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.imageurl,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LBORROWERCAT'
  ) LBORROWERCAT
  LEFT JOIN (
    SELECT
      categories.categorycode,
      categories.description
    FROM
      categories
  ) PATCAT
    ON PATCAT.categorycode = LBORROWERCAT.authorised_value
UNION
SELECT
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', LBORROWERCAT.category, '" target="_blank">Link to AV</a>') AS LINK,
  If(LBORROWERCAT.category IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBORROWERCAT.category) AS category,
  If(LBORROWERCAT.authorised_value IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBORROWERCAT.authorised_value) AS authorised_value,
  If(LBORROWERCAT.lib IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBORROWERCAT.lib) AS lib,
  If(PATCAT.categorycode IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", PATCAT.categorycode) AS categorycode,
  If(PATCAT.description IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", PATCAT.description) AS description
FROM
  (
    SELECT
      authorised_values.id,
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.imageurl,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LBORROWERCAT'
  ) LBORROWERCAT
  RIGHT JOIN (
    SELECT
      categories.categorycode,
      categories.description
    FROM
      categories
  ) PATCAT
    ON PATCAT.categorycode = LBORROWERCAT.authorised_value
ORDER BY
  LINK,
  category,
  authorised_value
LIMIT 1000

























