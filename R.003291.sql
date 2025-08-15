/*
R.003291

----------

Name: GHW - Authorised Values synchronization - borrower categories
Created by: George Williams

----------

Group: -
     -

Created on: 2019-12-30 11:46:03
Modified on: 2020-01-28 16:05:19
Date last run: 2022-11-10 10:24:13

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat('Link to AV') AS LINK,
  If(LBORROWERCAT.category IS NULL, "Possible error", LBORROWERCAT.category) AS category,
  If(LBORROWERCAT.authorised_value IS NULL, "Possible error", LBORROWERCAT.authorised_value) AS authorised_value,
  If(LBORROWERCAT.lib IS NULL, "Possible error", LBORROWERCAT.lib) AS lib,
  If(PATCAT.categorycode IS NULL, "Possible error", PATCAT.categorycode) AS categorycode,
  If(PATCAT.description IS NULL, "Possible error", PATCAT.description) AS description
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
  Concat('Link to AV') AS LINK,
  If(LBORROWERCAT.category IS NULL, "Possible error", LBORROWERCAT.category) AS category,
  If(LBORROWERCAT.authorised_value IS NULL, "Possible error", LBORROWERCAT.authorised_value) AS authorised_value,
  If(LBORROWERCAT.lib IS NULL, "Possible error", LBORROWERCAT.lib) AS lib,
  If(PATCAT.categorycode IS NULL, "Possible error", PATCAT.categorycode) AS categorycode,
  If(PATCAT.description IS NULL, "Possible error", PATCAT.description) AS description
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

























