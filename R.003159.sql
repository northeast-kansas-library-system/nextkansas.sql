/*
R.003159

----------

Name: GHW - Checkout and renewal count by collection code and shelving location - previous calendar month
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2019-01-27 20:45:59
Modified on: 2020-02-05 15:56:19
Date last run: 2020-08-10 14:59:35

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Last month's checkouts by library, collection code, and location</p>
<ul><li>Shows check-outs and renewals in the previous month by collection code and shelving location</li>
<li>at the library you specify</li>
<li>grouped and sorted by checkout branch and shelving location</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Checkouts without a checkout branch location will show as being checked out at NEKLS</p>
<p>Checkouts without a collection code will be counted as (Unclassified)</p>
<p></p>
<p>Partially replaces report 1929</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3159&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
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
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(statistics.location IS NULL, "PROC", If(statistics.location = "LVPLADULT", "ADULT", If(statistics.location = "LVPLCHILD", "CHILDRENS", If(statistics.location = "LVPLYA", "YOUNGADULT", If(statistics.location = "PAOLAADULT", "ADULT", If(statistics.location = "PAOLACHILD", "CHILDRENS", If(statistics.location = "PAOLAYA", "YOUNGADULT", statistics.location))))))) = 'ADULT'
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
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(statistics.location IS NULL, "PROC", If(statistics.location = "LVPLADULT", "ADULT", If(statistics.location = "LVPLCHILD", "CHILDRENS", If(statistics.location = "LVPLYA", "YOUNGADULT", If(statistics.location = "PAOLAADULT", "ADULT", If(statistics.location = "PAOLACHILD", "CHILDRENS", If(statistics.location = "PAOLAYA", "YOUNGADULT", statistics.location))))))) = 'YOUNGADULT'
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
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(statistics.location IS NULL, "PROC", If(statistics.location = "LVPLADULT", "ADULT", If(statistics.location = "LVPLCHILD", "CHILDRENS", If(statistics.location = "LVPLYA", "YOUNGADULT", If(statistics.location = "PAOLAADULT", "ADULT", If(statistics.location = "PAOLACHILD", "CHILDRENS", If(statistics.location = "PAOLAYA", "YOUNGADULT", statistics.location))))))) = 'CHILDRENS'
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
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      (If(statistics.location IS NULL, "PROC", If(statistics.location = "LVPLADULT", "ADULT", If(statistics.location = "LVPLCHILD", "CHILDRENS", If(statistics.location = "LVPLYA", "YOUNGADULT", If(statistics.location = "PAOLAADULT", "ADULT", If(statistics.location = "PAOLACHILD", "CHILDRENS", If(statistics.location = "PAOLAYA", "YOUNGADULT", statistics.location))))))) = 'CART' OR
        If(statistics.location IS NULL, "PROC", If(statistics.location = "LVPLADULT", "ADULT", If(statistics.location = "LVPLCHILD", "CHILDRENS", If(statistics.location = "LVPLYA", "YOUNGADULT", If(statistics.location = "PAOLAADULT", "ADULT", If(statistics.location = "PAOLACHILD", "CHILDRENS", If(statistics.location = "PAOLAYA", "YOUNGADULT", statistics.location))))))) = 'CATALOGING' OR
        If(statistics.location IS NULL, "PROC", If(statistics.location = "LVPLADULT", "ADULT", If(statistics.location = "LVPLCHILD", "CHILDRENS", If(statistics.location = "LVPLYA", "YOUNGADULT", If(statistics.location = "PAOLAADULT", "ADULT", If(statistics.location = "PAOLACHILD", "CHILDRENS", If(statistics.location = "PAOLAYA", "YOUNGADULT", statistics.location))))))) = 'PROC')
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



