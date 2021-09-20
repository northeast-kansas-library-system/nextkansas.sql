/*
R.003394

----------

Name: GHW - Monthly 220 Circulation statistics by collection code
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2020-12-31 17:40:07
Modified on: 2021-07-29 17:22:09
Date last run: 2021-09-01 00:20:02

----------

Public: 0
Expiry: 300

----------

Monthly statistics - should be run on schedule only - staff at libraries should run report 3159 if they just want data for their library.

----------
*/

SELECT
  branchccodes.branchname,
  branchccodes.lib,
  Coalesce(all_lm.CKO_RENEW, "0") AS CKO_RENW_ALL,
  Coalesce(adult_lm.CKO_RENEW, "0") AS CKO_RENEW_ADULT,
  Coalesce(ya_lm.CKO_RENEW, "0") AS CKO_RENEW_YA,
  Coalesce(childrens_lm.CKO_RENEW, "0") AS CKO_RENEW_CHILDRENS,
  Coalesce(other_lm.CKO_RENEW, "0") AS CKO_RENEW_OTHER
FROM
  (SELECT
      branches.branchcode,
      authorised_values.authorised_value,
      authorised_values.lib,
      branches.branchname
    FROM
      branches,
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    ORDER BY
      branches.branchcode,
      authorised_values.lib) branchccodes LEFT JOIN
  (SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
      Count(*) AS CKO_RENEW,
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)) all_lm ON
      all_lm.branch = branchccodes.branchcode AND
      all_lm.CCODE = branchccodes.authorised_value LEFT JOIN
  (SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
      Count(*) AS CKO_RENEW,
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(statistics.location, "CART") = 'ADULT' OR
        Coalesce(statistics.location, "CART") = 'LVPLADULT' OR
        Coalesce(statistics.location, "CART") = 'PAOLAADULT' OR
        Coalesce(statistics.location, "CART") = 'BALDADULT')
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)) adult_lm ON
      adult_lm.branch = branchccodes.branchcode AND
      adult_lm.CCODE = branchccodes.authorised_value LEFT JOIN
  (SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
      Count(*) AS CKO_RENEW,
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(statistics.location, "CART") LIKE "%YA%" OR
        Coalesce(statistics.location, "CART") LIKE "YOUNGADULT")
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)) ya_lm ON
      ya_lm.branch = branchccodes.branchcode AND
      ya_lm.CCODE = branchccodes.authorised_value LEFT JOIN
  (SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
      Count(*) AS CKO_RENEW,
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(statistics.location, "CART") = 'CHILDRENS' OR
        Coalesce(statistics.location, "CART") = 'LVPLCHILD' OR
        Coalesce(statistics.location, "CART") = 'PAOLACHILD' OR
        Coalesce(statistics.location, "CART") = 'BALDCHILD')
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)) childrens_lm ON
      childrens_lm.branch = branchccodes.branchcode AND
      childrens_lm.CCODE = branchccodes.authorised_value LEFT JOIN
  (SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
      Count(*) AS CKO_RENEW,
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Coalesce(statistics.location, "CART") NOT LIKE "%ADULT%" AND
      Coalesce(statistics.location, "CART") NOT LIKE "%CHILD%" AND
      Coalesce(statistics.location, "CART") NOT LIKE "%YA%"
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)) other_lm ON
      other_lm.branch = branchccodes.branchcode AND
      other_lm.CCODE = branchccodes.authorised_value
WHERE
  branchccodes.branchcode LIKE '%'
ORDER BY
  branchccodes.branchname,
  branchccodes.lib



