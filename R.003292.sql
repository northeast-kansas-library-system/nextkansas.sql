/*
R.003292

----------

Name: GHW - Authorised Values Synchronization - Branch names
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-12-30 12:37:13
Modified on: 2020-01-28 16:04:55
Date last run: 2021-04-26 17:05:00

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', LBRNAME.category, '" target="_blank">Link to AV</a>') AS LINK,
  If(LBRNAME.category IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBRNAME.category) AS category,
  If(LBRNAME.authorised_value IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBRNAME.authorised_value) AS authorised_value,
  If(LBRNAME.lib IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBRNAME.lib) AS lib,
  If(BRANCHESS.branchcode IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", BRANCHESS.branchcode) AS branchcode,
  If(BRANCHESS.branchname IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", BRANCHESS.branchname) AS branchname
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
      authorised_values.category = 'LBRNAME'
  ) LBRNAME
  LEFT JOIN (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) BRANCHESS
    ON BRANCHESS.branchname = LBRNAME.lib
GROUP BY
  LBRNAME.category,
  LBRNAME.authorised_value,
  LBRNAME.lib,
  BRANCHESS.branchcode,
  BRANCHESS.branchname
UNION
SELECT
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', LBRNAME.category, '" target="_blank">Link to AV</a>') AS LINK,
  If(LBRNAME.category IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBRNAME.category) AS category,
  If(LBRNAME.authorised_value IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBRNAME.authorised_value) AS authorised_value,
  If(LBRNAME.lib IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBRNAME.lib) AS lib,
  If(BRANCHESS.branchcode IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", BRANCHESS.branchcode) AS branchcode,
  If(BRANCHESS.branchname IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", BRANCHESS.branchname) AS branchname
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
      authorised_values.category = 'LBRNAME'
  ) LBRNAME
  RIGHT JOIN (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) BRANCHESS
    ON BRANCHESS.branchname = LBRNAME.lib
GROUP BY
  LBRNAME.category,
  LBRNAME.authorised_value,
  LBRNAME.lib,
  BRANCHESS.branchcode,
  BRANCHESS.branchname
LIMIT 1000



