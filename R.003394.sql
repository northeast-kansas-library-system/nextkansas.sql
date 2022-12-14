/*
R.003394

----------

Name: GHW - C1 Circulation by item details - collection code - Next Search Catlog
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2020-12-31 17:40:07
Modified on: 2022-03-10 15:14:36
Date last run: 2022-12-01 00:35:02

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Circulation by item details spreadsheet report - circulation by collection code</p> 
<ul><li>Shows counts of check-outs and renewals in the previous calendar month</li> 
<li>At all Next Search Catalog libraries</li> 
<li>grouped and sorted by library name</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p>SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."  If the shelving location is completely ambiguous, the circulation is counted in the CKO_RENEW_OTHER column.</p> 
<p></p> 
<ul> 
  <li>CKO_RENEW_ADULT includes items with these shelving locations:</li> 
  <ul> 
    <li>Adult</li> 
    <li>~Display - BALDWIN - Adult</li> 
    <li>~Display - LEAVENWRTH - Adult</li> 
    <li>~Display - PAOLA - Adult</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Adult" locations</li> 
  </ul> 
  <br /> 
  <li>CKO_RENEW_YA includes items with these shelving locations:</li> 
  <ul> 
    <li>Young adult</li> 
    <li>~Display - BALDWIN - Young Adult</li> 
    <li>~Display - LEAVENWRTH - Young adult</li> 
    <li>~Display - PAOLA - Young adult</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations</li> 
  </ul> 
  <br /> 
  <li>CKO_RENEW_CHILDRENS includes items with these shelving locations:</li> 
  <ul> 
    <li>Childrens</li> 
    <li>~Display - BALDWIN - Childrens</li> 
    <li>~Display - LEAVENWRTH - Children's</li> 
    <li>~Display - PAOLA - Children's</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations</li> 
  </ul> 
  <br /> 
  <li>CKO_RENEW_OTHER includes items with these shelving locations:</li> 
  <ul> 
    <li>Cataloging</li> 
    <li>Processing Center</li> 
    <li>Any other situation where the recorded shelving location is "Recently returned" but the item's permanent location is ambiguous</li> 
    <li>Any items where the recorded shelving location is blank or unknown</li> 
  </ul> 
</ul> 
  <br /> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3394">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #item #details #ccode</p> 
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
      If(    Coalesce(statistics.location, "PROC") = "CART", 
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
      If(    Coalesce(statistics.location, "PROC") = "CART", 
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
      If(    Coalesce(statistics.location, "PROC") = "CART", 
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
      If(    Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%ADULT%" AND 
      If(    Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location,"PROC") 
      ) NOT LIKE "%YA%" AND 
      If(    Coalesce(statistics.location, "PROC") = "CART", 
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

























