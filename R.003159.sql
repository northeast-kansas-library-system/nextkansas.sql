/*
R.003159

----------

Name: GHW - Checkout and renewal count by collection code and shelving location - previous calendar month
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2019-01-27 20:45:59
Modified on: 2022-02-10 10:26:09
Date last run: 2022-03-09 10:06:06

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
  branchccodes.branchname, 
  branchccodes.lib, 
  Coalesce(SUM(all_lm.CKO_RENEW), "0") AS CKO_RENW_ALL, 
  Coalesce(SUM(adult_lm.CKO_RENEW), "0") AS CKO_RENEW_ADULT, 
  Coalesce(SUM(ya_lm.CKO_RENEW), "0") AS CKO_RENEW_YA, 
  Coalesce(SUM(childrens_lm.CKO_RENEW), "0") AS CKO_RENEW_CHILDRENS, 
  Coalesce(SUM(other_lm.CKO_RENEW), "0") AS CKO_RENEW_OTHER 
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
      authorised_values.category = 'CCODE' AND 
      branches.branchcode LIKE <<Choose your library|ZBRAN>>
    ORDER BY 
      branches.branchcode, 
      authorised_values.lib) branchccodes LEFT JOIN 
  ( 
    SELECT 
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch, 
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE, 
      Count(*) AS CKO_RENEW 
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
  ) all_lm ON all_lm.branch = branchccodes.branchcode AND 
      all_lm.CCODE = branchccodes.authorised_value LEFT JOIN 
  ( 
    SELECT 
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch, 
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE, 
      Count(*) AS CKO_RENEW 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) LIKE "%ADULT%" 
    GROUP BY 
      If(statistics.branch IS NULL, "NEKLS", statistics.branch), 
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) 
  ) adult_lm ON adult_lm.branch = branchccodes.branchcode AND 
      adult_lm.CCODE = branchccodes.authorised_value LEFT JOIN 
  ( 
    SELECT 
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch, 
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE, 
      Count(*) AS CKO_RENEW 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) LIKE "%YA%" 
    GROUP BY 
      If(statistics.branch IS NULL, "NEKLS", statistics.branch), 
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) 
  ) ya_lm ON ya_lm.branch = branchccodes.branchcode AND 
      ya_lm.CCODE = branchccodes.authorised_value LEFT JOIN 
  ( 
    SELECT 
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch, 
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE, 
      Count(*) AS CKO_RENEW 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) LIKE "%CHILD%" 
    GROUP BY 
      If(statistics.branch IS NULL, "NEKLS", statistics.branch), 
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) 
  ) childrens_lm ON childrens_lm.branch = branchccodes.branchcode AND 
      childrens_lm.CCODE = branchccodes.authorised_value LEFT JOIN 
  ( 
    SELECT 
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch, 
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE, 
      Count(*) AS CKO_RENEW 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%ADULT%" AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location,"PROC") 
      ) NOT LIKE "%YA%" AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%CHILD%" 
    GROUP BY 
      If(statistics.branch IS NULL, "NEKLS", statistics.branch), 
      If(statistics.ccode IS NULL, "XXX", statistics.ccode) 
) other_lm ON other_lm.branch = branchccodes.branchcode AND 
      other_lm.CCODE = branchccodes.authorised_value 
GROUP BY 
  branchccodes.branchname, 
  branchccodes.lib 
ORDER BY 
  branchccodes.branchname, 
  branchccodes.lib

























