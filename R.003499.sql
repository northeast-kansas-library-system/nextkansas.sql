/*
R.003499

----------

Name: GHW - B1 Circulation by library details - hourly statistics - Next Search Catalog
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2021-04-30 15:05:03
Modified on: 2022-03-10 15:11:03
Date last run: 2022-03-10 11:13:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Circulation by library details spreadsheet report - hourly circulation</p> 
<ul><li>Shows counts of check-outs, renewals, and returns in the previous calendar month</li> 
<li>At all Next Search Catalog libraries</li> 
<li>grouped and sorted by library name, date, and hour</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<ul> 
  <li>CKO =  number of items newly checked out</li> 
  <li>RENEW = number of items renewed</li> 
  <li>RETURNS = number of items checked in</li> 
  <li>TOTAL_CKO_RENEW_RETURN = sum of the previous 3 columns</li> 
  <li>CKO_BORROWERS = number of unique accounts used to check out the items in the CKO column</li> 
  <li>RENEW_BORROWERS = number of unique accounts used to renew the items in the RENEW column</li> 
  <li>CKO_AND_RENEW_BORROWERS = number of unique accounts used to check out and renew items</li> 
</ul> 
<p></p> 
<p>OPAC renewals are counted as occurring at the library where the item was originally checked out.  This is why you may see data for days and times that your library is closed.</p> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3499">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #library #details #hourly</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  branchccodes.branchname AS CHECK_OUT_LIBRARY, 
  branchccodes.lib AS COLLECTION_CODE, 
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
      branches.branchcode LIKE "%" 
    ORDER BY 
      branches.branchcode, 
      authorised_values.lib 
    ) branchccodes 
  LEFT JOIN 
    (SELECT 
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
    ) all_lm 
  ON all_lm.branch = branchccodes.branchcode AND 
    all_lm.CCODE = branchccodes.authorised_value LEFT JOIN 
    (SELECT 
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
    ) adult_lm 
  ON adult_lm.branch = branchccodes.branchcode AND 
    adult_lm.CCODE = branchccodes.authorised_value LEFT JOIN 
    (SELECT 
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
    ) ya_lm 
  ON ya_lm.branch = branchccodes.branchcode AND 
    ya_lm.CCODE = branchccodes.authorised_value LEFT JOIN 
    (SELECT 
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
    ) childrens_lm 
  ON childrens_lm.branch = branchccodes.branchcode AND 
    childrens_lm.CCODE = branchccodes.authorised_value LEFT JOIN 
    (SELECT 
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
    ) other_lm 
  ON other_lm.branch = branchccodes.branchcode AND 
    other_lm.CCODE = branchccodes.authorised_value 
GROUP BY 
  branchccodes.branchname, 
  branchccodes.lib 
ORDER BY 
  branchccodes.branchname, 
  branchccodes.lib 

























