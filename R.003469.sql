/*
R.003469

----------

Name: GHW - Synchronize locations
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-02 14:45:41
Modified on: 2021-03-02 14:45:41
Date last run: 2022-01-14 17:29:37

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    '<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', 
    locs.category, 
    '" target="_blank">Link to LOC</a>'
  ) AS LINK_TO_LOC,
  If(
    locs.category IS NULL, 
    "<span style='background-color: red; color: yellow'>Possible errror</span>", 
    locs.category
  ) AS CATEGORY,
  locs.authorised_value AS LOC,
  If(
    llocs.category IS NULL, 
    "<span style='background-color: red; color: yellow'>Possible errror</span>", 
    llocs.category
  ) AS ALT_CATEGORY,
  Concat(
    '<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', 
    llocs.category, 
    '" target="_blank">Link to LLOC</a>'
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
    '<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', 
    locsx.category, 
    '" target="_blank">Link to LOC</a>'
  ) AS LINK,
  If(
    locsx.category IS NULL, 
    "<span style='background-color: red; color: yellow'>Possible errror</span>", 
    locsx.category
  ) AS category,
  locsx.authorised_value,
  If(
    llocsx.category IS NULL, 
    "<span style='background-color: red; color: yellow'>Possible errror</span>", 
    llocsx.category
  ) AS category1,
  Concat(
    '<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', 
    llocsx.category, 
    '" target="_blank">Link to LLOC</a>'
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

























