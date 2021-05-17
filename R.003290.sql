/*
R.003290

----------

Name: GHW - Authorised Values Synchronization - BRANCHES
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-12-30 11:06:11
Modified on: 2020-01-28 16:06:04
Date last run: 2021-04-26 17:05:11

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', LBRANCH.category, '" target="_blank">Link to AV</a>') AS LINK,
  If(LBRANCH.category IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBRANCH.category) AS category,
  If(LBRANCH.authorised_value IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBRANCH.authorised_value) AS authorised_value,
  If(LBRANCH.lib IS NULL, "<span style='background-color: red; color: yellow'>Possible error</span>", LBRANCH.lib) AS lib,
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
      (authorised_values.category = 'LBRANCH' OR
        authorised_values.category = 'ZBRAN')
  ) LBRANCH
  LEFT JOIN (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) BRANCHESS
    ON BRANCHESS.branchcode = LBRANCH.authorised_value
GROUP BY
  LBRANCH.category,
  LBRANCH.authorised_value,
  LBRANCH.lib,
  BRANCHESS.branchcode,
  BRANCHESS.branchname
UNION
SELECT
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', ZBRAN.category, '" target="_blank">Link to AV</a>') AS LINK,
  ZBRAN.category,
  ZBRAN.authorised_value,
  ZBRAN.lib,
  BRANCHESS.branchcode,
  BRANCHESS.branchname
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
      (authorised_values.category = 'LBRANCH' OR
        authorised_values.category = 'ZBRAN')
  ) ZBRAN
  RIGHT JOIN (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) BRANCHESS
    ON BRANCHESS.branchcode = ZBRAN.authorised_value
GROUP BY
  ZBRAN.category,
  ZBRAN.authorised_value,
  ZBRAN.lib,
  BRANCHESS.branchcode,
  BRANCHESS.branchname
ORDER BY
  category,
  authorised_value
LIMIT 10000



