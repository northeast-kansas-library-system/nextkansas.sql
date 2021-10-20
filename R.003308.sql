/*
R.003308

----------

Name: GHW - Authorised Values Synchronization - Collection Codes
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-01-28 14:21:20
Modified on: 2021-07-08 15:15:42
Date last run: 2021-07-08 15:19:04

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    '<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=',
    ccodes.category, 
    '" target="_blank">Link to CCODE</a>'
  ) AS LINK_TO_CCODE,
  If(
    ccodes.category IS NULL,
    "<span style='background-color: red; color: yellow'>Possible errror</span>",
    ccodes.category
  ) AS CATEGORY,
  ccodes.authorised_value AS CCODE,
  If(
    lccodes.category IS NULL,
    "<span style='background-color: red; color: yellow'>Possible errror</span>",
    lccodes.category
  ) AS ALT_CATEGORY,
  Concat(
    '<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=',
    lccodes.category, 
    '" target="_blank">Link to LCCODE</a>'
  ) AS LINK_TO_LCCODE,
  lccodes.authorised_value AS LCCODE,
  ccodes.lib AS LIB,
  lccodes.lib AS ALT_LIB,
  ccodes.lib_opac AS OPAC,
  lccodes.lib_opac AS ALT_OPTC
FROM
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LCCODE') lccodes ON
      lccodes.authorised_value = ccodes.authorised_value
UNION
SELECT
  Concat(
    '<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=',
    ccodesx.category, 
    '" target="_blank">Link to CCODE</a>'
  ) AS LINK,
  If(
    ccodesx.category IS NULL,
    "<span style='background-color: red; color: yellow'>Possible errror</span>",
    ccodesx.category
  ) AS category,
  ccodesx.authorised_value,
  If(
    lccodesx.category IS NULL,
    "<span style='background-color: red; color: yellow'>Possible errror</span>",
    lccodesx.category
  ) AS category1,
  Concat(
    '<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=',
    lccodesx.category, 
    '" target="_blank">Link to LCCODE</a>'
  ) AS LINK1,
  lccodesx.authorised_value AS authorised_value1,
  ccodesx.lib,
  lccodesx.lib AS lib1,
  ccodesx.lib_opac,
  lccodesx.lib_opac AS lib_opac1
FROM
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodesx RIGHT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LCCODE') lccodesx ON
      lccodesx.authorised_value = ccodesx.authorised_value
ORDER BY
  LINK_TO_CCODE,
  CCODE
LIMIT 1000

























