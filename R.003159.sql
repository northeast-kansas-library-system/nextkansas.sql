/*
R.003159

----------

Name: GHW - Checkout and renewal count by collection code and shelving location - previous calendar month
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2019-01-27 20:45:59
Modified on: 2020-12-02 14:46:32
Date last run: 2020-12-07 12:35:11

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
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3159&reportname=GHW%20-%20Checkout%20and%20renewal%20count%20by%20collection%20code%20and%20shelving%20location%20-%20previous%20calendar%20month&sql_params=%25&param_name=Choose%20your%20library%7CLBRANCH">Click here to download for all libraries as a csv file</a></p>
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
  (SELECT
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
      (Coalesce(statistics.location, "CART") = 'YOUNGADULT' OR
          Coalesce(statistics.location, "CART") = 'LVPLYA' OR
          Coalesce(statistics.location, "CART") = 'PAOLAYA' OR
          Coalesce(statistics.location, "CART") = 'BALDYA')
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
      Coalesce(statistics.location, "CART") <> 'ADULT' AND
      Coalesce(statistics.location, "CART") <> 'LVPLADULT' AND
      Coalesce(statistics.location, "CART") <> 'PAOLAADULT' AND
      Coalesce(statistics.location, "CART") <> 'BALDADULT' AND
      Coalesce(statistics.location, "CART") <> 'YOUNGADULT' AND
      Coalesce(statistics.location, "CART") <> 'LVPLYA' AND
      Coalesce(statistics.location, "CART") <> 'PAOLAYA' AND
      Coalesce(statistics.location, "CART") <> 'BALDYA' AND
      Coalesce(statistics.location, "CART") <> 'CHILDRENS' AND
      Coalesce(statistics.location, "CART") <> 'LVPLCHILD' AND
      Coalesce(statistics.location, "CART") <> 'PAOLACHILD' AND
      Coalesce(statistics.location, "CART") <> 'BALDCHILD'
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(statistics.ccode IS NULL, "XXX", statistics.ccode)) other_lm ON
      other_lm.branch = branchccodes.branchcode AND
      other_lm.CCODE = branchccodes.authorised_value
WHERE
  branchccodes.branchcode LIKE <<Choose your library|LBRANCH>>
ORDER BY
  branchccodes.branchcode,
  branchccodes.lib



