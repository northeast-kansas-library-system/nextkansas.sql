/*
R.003292

----------

Name: GHW - Authorised Values Synchronization - Branch names
Created by: George Williams

----------

Group: -
     -

Created on: 2019-12-30 12:37:13
Modified on: 2020-01-28 16:04:55
Date last run: 2023-10-23 17:07:44

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat('Link to AV') AS LINK,
  If(LBRNAME.category IS NULL, "Possible error", LBRNAME.category) AS category,
  If(LBRNAME.authorised_value IS NULL, "Possible error", LBRNAME.authorised_value) AS authorised_value,
  If(LBRNAME.lib IS NULL, "Possible error", LBRNAME.lib) AS lib,
  If(BRANCHESS.branchcode IS NULL, "Possible error", BRANCHESS.branchcode) AS branchcode,
  If(BRANCHESS.branchname IS NULL, "Possible error", BRANCHESS.branchname) AS branchname
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
  Concat('Link to AV') AS LINK,
  If(LBRNAME.category IS NULL, "Possible error", LBRNAME.category) AS category,
  If(LBRNAME.authorised_value IS NULL, "Possible error", LBRNAME.authorised_value) AS authorised_value,
  If(LBRNAME.lib IS NULL, "Possible error", LBRNAME.lib) AS lib,
  If(BRANCHESS.branchcode IS NULL, "Possible error", BRANCHESS.branchcode) AS branchcode,
  If(BRANCHESS.branchname IS NULL, "Possible error", BRANCHESS.branchname) AS branchname
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

























