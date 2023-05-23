/*
R.003419

----------

Name: A2 Monthly overview - Circulation
Created by: George H Williams

----------

Group: Statistics
     2023 beginning of month statistics

Created on: 2021-02-04 16:59:13
Modified on: 2023-02-10 14:08:40
Date last run: 2023-05-01 16:40:04

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Monthly overview - circulation statistics</p> 
<ul><li>Shows circulation and renewal counts for the previous calendar month</li> 
<li>At all Next Search Catalog libraries</li> 
<li>grouped and sorted by branch name</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p>Generates data for:</p> 
<ul> 
  <li>CHECKOUT_RENEW_LM = all items checked out or renewed at this library last month</li> 
  <li>CHECKOUT_LM = all items checked out at this library last month</li> 
  <li>RENEW_LM = all items renewed at this library last month</li> 
  <li>RETURN_LM = all items returned at this library last month</li> 
  <li>CR_ADULT_LM includes items with these shelving locations:</li> 
  <ul> 
    <li>Adult</li> 
    <li>~Display - BALDWIN - Adult</li> 
    <li>~Display - LEAVENWRTH - Adult</li> 
    <li>~Display - PAOLA - Adult</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Adult" locations</li> 
  </ul> 
  <li>CR_YOUTH_LM includes items with these shelving locations:</li> 
  <ul> 
    <li>Young adult</li> 
    <li>~Display - BALDWIN - Young Adult</li> 
    <li>~Display - LEAVENWRTH - Young adult</li> 
    <li>~Display - PAOLA - Young adult</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations</li> 
    <li>Childrens</li> 
    <li>~Display - BALDWIN - Childrens</li> 
    <li>~Display - LEAVENWRTH - Children's</li> 
    <li>~Display - PAOLA - Children's</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations</li> 
    <li>Cataloging</li> 
    <li>Processing Center</li> 
    <li>Any other situation where the recorded shelving location is "Recently returned" but the item's permanent location is ambiguous</li> 
    <li>Any items where the recorded shelving location is blank or unknown</li> 
  </ul> 
</ul> 
<p></p> 
<p class="updated">SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."  If the shelving location is completely ambiguous, the circulation is counted as a "Youth" circulation in the CR_YOUTH_LM column.</p> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3419">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #overview #monthly_overview</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  branches.branchname, 
  Coalesce(CIR_RENEW_LM.count, 0) AS CHECKOUT_RENEW_LM, 
  Coalesce(CKO_LM.count, 0) AS CHECKOUT_LM, 
  Coalesce(RENEW_LM.count, 0) AS RENEW_LM, 
  Coalesce(RETURN_LM.count, 0) AS RETURN_LM, 
  Coalesce(ADULT.count, 0) AS CR_ADULT_LM, 
  Coalesce(YOUTH.count, 0) AS CR_YOUTH_LM 
FROM 
  branches LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) CIR_RENEW_LM 
  ON branches.branchcode = CIR_RENEW_LM.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "ADULT") = "CART", 
        items.permanent_location, 
        Coalesce(statistics.location, "ADULT") 
      ) LIKE "%AD%" 
    GROUP BY 
      statistics.branch 
    ) ADULT 
  ON branches.branchcode = ADULT.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "ADULT") = "CART", 
        items.permanent_location, 
        Coalesce(statistics.location, "ADULT") 
      ) NOT LIKE "%AD%" 
    GROUP BY 
      statistics.branch 
    ) YOUTH 
  ON branches.branchcode = YOUTH.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'issue' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) CKO_LM 
  ON CKO_LM.branch = branches.branchcode LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'renew' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) RENEW_LM 
  ON RENEW_LM.branch = branches.branchcode 
  LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'return' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) RETURN_LM 
  ON RETURN_LM.branch = branches.branchcode 
GROUP BY 
  branches.branchname 
ORDER BY 
  branches.branchname 

























