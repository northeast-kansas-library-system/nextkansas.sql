/*
R.003469

----------

Name: GHW - Synchronize locations
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-02 14:45:41
Modified on: 2021-03-02 14:45:41
Date last run: 2024-08-28 08:36:18

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    'Link to LOC'
  ) AS LINK_TO_LOC,
  If(
    locs.category IS NULL, 
    "Possible errror", 
    locs.category
  ) AS CATEGORY,
  locs.authorised_value AS LOC,
  If(
    llocs.category IS NULL, 
    "Possible errror", 
    llocs.category
  ) AS ALT_CATEGORY,
  Concat(
    'Link to LLOC'
  ) AS LINK_TO_LLOC,
  llocs.authorised_value AS LLOC
FROM
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LLOC') llocs ON llocs.authorised_value =
      locs.authorised_value
UNION
SELECT
  Concat(
    'Link to LOC'
  ) AS LINK,
  If(
    locsx.category IS NULL, 
    "Possible errror", 
    locsx.category
  ) AS category,
  locsx.authorised_value,
  If(
    llocsx.category IS NULL, 
    "Possible errror", 
    llocsx.category
  ) AS category1,
  Concat(
    'Link to LLOC'
  ) AS LINK1,
  llocsx.authorised_value AS authorised_value1
FROM
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locsx RIGHT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LLOC') llocsx ON llocsx.authorised_value =
      locsx.authorised_value
ORDER BY
  LOC,
  LLOC
LIMIT 1000

























