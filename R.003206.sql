/*
R.003206

----------

Name: GHW -X
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-05-22 23:43:09
Modified on: 2019-05-23 00:18:13
Date last run: 2019-11-08 21:52:08

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branchccodes.branchcode,
  branchccodes.lib,
  all_lm.CKO_RENEW AS CKO_RENW_ALL,
  adult_lm.CKO_RENEW AS CKO_RENEW_ADULT,
  ya_lm.CKO_RENEW AS CKO_RENEW_YA,
  childrens_lm.CKO_RENEW AS CKO_RENEW_CHILDRENS,
  other_lm.CKO_RENEW AS CKO_RENEW_OTHER
FROM
  (
    SELECT
      branches.branchcode,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      branches,
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    ORDER BY
      branches.branchcode,
      authorised_values.lib
  ) branchccodes
  LEFT JOIN (
    SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
      Count(*) AS CKO_RENEW,
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
    FROM
      statistics
    WHERE
      (Month(statistics.datetime) = @month := <<Choose month|Month>> COLLATE utf8mb4_unicode_ci) AND
      (Year(statistics.datetime) = @year := <<Choose year|Year>> COLLATE utf8mb4_unicode_ci) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)
  ) all_lm
    ON all_lm.branch = branchccodes.branchcode AND
      all_lm.CCODE = branchccodes.authorised_value
  LEFT JOIN (
    SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
      Count(*) AS CKO_RENEW,
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = 04 AND
      Year(statistics.datetime) = 2019 AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(
        statistics.location IS NULL,
        "PROC",
        If(
          statistics.location = "LVPLADULT",
          "ADULT",
          If(
            statistics.location = "LVPLCHILD",
            "CHILDRENS",
            If(
              statistics.location = "LVPLYA",
              "YOUNGADULT",
              statistics.location
            )
          )
        )
      ) = 'ADULT'
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)
  ) adult_lm
    ON adult_lm.branch = branchccodes.branchcode AND
      adult_lm.CCODE = branchccodes.authorised_value
  LEFT JOIN (
    SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
      Count(*) AS CKO_RENEW,
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = @month AND
      Year(statistics.datetime) = @year AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(
        statistics.location IS NULL,
        "PROC",
        If(
          statistics.location = "LVPLADULT",
          "ADULT",
          If(
            statistics.location = "LVPLCHILD",
            "CHILDRENS",
            If(
              statistics.location = "LVPLYA",
              "YOUNGADULT",
              statistics.location
            )
          )
        )
      ) = 'YOUNGADULT'
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)
  ) ya_lm
    ON ya_lm.branch = branchccodes.branchcode AND
      ya_lm.CCODE = branchccodes.authorised_value
  LEFT JOIN (
    SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
      Count(*) AS CKO_RENEW,
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = @month AND
      Year(statistics.datetime) = @year AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(
        statistics.location IS NULL,
        "PROC",
        If(
          statistics.location = "LVPLADULT",
          "ADULT",
          If(
            statistics.location = "LVPLCHILD",
            "CHILDRENS",
            If(
              statistics.location = "LVPLYA",
              "YOUNGADULT",
              statistics.location
            )
          )
        )
      ) = 'CHILDRENS'
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)
  ) childrens_lm
    ON childrens_lm.branch = branchccodes.branchcode AND
      childrens_lm.CCODE = branchccodes.authorised_value
  LEFT JOIN (
    SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
      Count(*) AS CKO_RENEW,
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
    FROM
      statistics
    WHERE
    Month(statistics.datetime) = @month AND
    Year(statistics.datetime) = @year AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      (If(
        statistics.location IS NULL,
        "PROC",
        If(
          statistics.location = "LVPLADULT",
          "ADULT",
          If(
            statistics.location = "LVPLCHILD",
            "CHILDRENS",
            If(
              statistics.location = "LVPLYA",
              "YOUNGADULT",
              statistics.location
            )
          )
        )
      ) = 'CART' OR
        If(
          statistics.location IS NULL,
          "PROC",
          If(
            statistics.location = "LVPLADULT",
            "ADULT",
            If(
              statistics.location = "LVPLCHILD",
              "CHILDRENS",
              If(
                statistics.location = "LVPLYA",
                "YOUNGADULT",
                statistics.location
              )
            )
          )
        ) = 'CATALOGING' OR
        If(
          statistics.location IS NULL,
          "PROC",
          If(
            statistics.location = "LVPLADULT",
            "ADULT",
            If(
              statistics.location = "LVPLCHILD",
              "CHILDRENS",
              If(
                statistics.location = "LVPLYA",
                "YOUNGADULT",
                statistics.location
              )
            )
          )
        ) = 'PROC')
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)
  ) other_lm
    ON other_lm.branch = branchccodes.branchcode AND
      other_lm.CCODE = branchccodes.authorised_value
WHERE
  branchccodes.branchcode LIKE <<Choose your library|LBRANCH>>
ORDER BY
  branchccodes.branchcode,
  branchccodes.lib

























