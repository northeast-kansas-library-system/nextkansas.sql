/*
R.002975

----------

Name: GHW - G2 Request and sharing statistics - request statistics - Next Search Catalog
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2017-07-11 11:52:53
Modified on: 2022-03-11 15:44:34
Date last run: 2022-03-11 15:39:29

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Request and sharing statistics - request statistics</p> 
<ul><li>during the previous calendar month</li> 
<li>at all system libraries</li> 
<li>grouped and sorted by pick up library</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.11</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=2975">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #requests #count</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 






----------
*/



SELECT 
  branches.branchname AS "Library", 
  Sum(Coalesce(requests_placed.Count_reserve_id, 0)) AS "Requests placed last month", 
  Coalesce(requests_filled.Count_reserve_id, 0) AS "Requests filled last month", 
  Coalesce(requests_cancelled_from_hold_shelf.Count_reserve_id, 0) AS "Requests cancelled after placement on hold shelf", 
  Coalesce(requests_cancelled_in_transit.Count_reserve_id, 0) AS "Requests cancelled while in transit", 
  Coalesce(requests_cancelled_before_pulled.Count_reserve_id, 0) AS "Requests cancelled before an item was found", 
  Coalesce(requests_cancelled.Count_reserve_id, 0) AS "Requests cancelled total", 
  Coalesce(requests_expired_unfilled.Count_reserve_id, 0) AS "Requests expired last month", 
  Sum(Coalesce(requests_placed_staff.Count_reserve_id, 0)) AS "Requests placed by staff", 
  (Sum(Coalesce(requests_placed.Count_reserve_id, 0)) - Sum(Coalesce(requests_placed_staff.Count_reserve_id, 0))) AS "Requests placed in the OPAC" 
FROM 
  branches LEFT JOIN 
    (SELECT 
      reserves.branchcode, 
      Count(reserves.reserve_id) AS Count_reserve_id 
    FROM 
      reserves 
    WHERE 
      Year(reserves.reservedate) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(reserves.reservedate) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      reserves.branchcode 
    UNION 
    SELECT 
      old_reserves.branchcode, 
      Count(old_reserves.reserve_id) AS Count_reserve_id 
    FROM 
      old_reserves 
    WHERE 
      Month(old_reserves.reservedate) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(old_reserves.reservedate) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      old_reserves.branchcode 
    ) requests_placed 
  ON branches.branchcode = requests_placed.branchcode LEFT JOIN 
    (SELECT 
      old_reserves.branchcode, 
      Count(old_reserves.reserve_id) AS Count_reserve_id 
    FROM 
      old_reserves JOIN 
      action_logs ON action_logs.object = old_reserves.reserve_id 
    WHERE 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      old_reserves.found = 'F' AND 
      action_logs.module = 'HOLDS' AND 
      action_logs.action LIKE "DEL%" 
    GROUP BY 
      old_reserves.branchcode 
    ) requests_filled 
  ON branches.branchcode = requests_filled.branchcode LEFT JOIN 
    (SELECT 
      old_reserves.branchcode, 
      Count(old_reserves.reserve_id) AS Count_reserve_id 
    FROM 
      old_reserves 
    WHERE 
      Month(old_reserves.cancellationdate) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(old_reserves.cancellationdate) = Year(Now() - INTERVAL 1 MONTH) AND 
      (old_reserves.found <> 'F' OR 
        old_reserves.found IS NULL) 
    GROUP BY 
      old_reserves.branchcode 
    ) requests_cancelled 
  ON branches.branchcode = requests_cancelled.branchcode LEFT JOIN 
    (SELECT 
      old_reserves.branchcode, 
      Count(old_reserves.reserve_id) AS Count_reserve_id 
    FROM 
      old_reserves 
    WHERE 
      Month(old_reserves.cancellationdate) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(old_reserves.cancellationdate) = Year(Now() - INTERVAL 1 MONTH) AND 
      old_reserves.found = 'T' 
    GROUP BY 
      old_reserves.branchcode 
    ) requests_cancelled_in_transit 
  ON branches.branchcode = requests_cancelled_in_transit.branchcode LEFT JOIN 
    (SELECT 
      old_reserves.branchcode, 
      Count(old_reserves.reserve_id) AS Count_reserve_id 
    FROM 
      old_reserves 
    WHERE 
      Month(old_reserves.cancellationdate) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(old_reserves.cancellationdate) = Year(Now() - INTERVAL 1 MONTH) AND 
      old_reserves.found = 'W' 
    GROUP BY 
      old_reserves.branchcode 
    ) requests_cancelled_from_hold_shelf 
  ON branches.branchcode = requests_cancelled_from_hold_shelf.branchcode LEFT JOIN 
    (SELECT 
      old_reserves.branchcode, 
      Count(old_reserves.reserve_id) AS Count_reserve_id 
    FROM 
      old_reserves 
    WHERE 
      Month(old_reserves.cancellationdate) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(old_reserves.cancellationdate) = Year(Now() - INTERVAL 1 MONTH) AND 
      old_reserves.found IS NULL 
    GROUP BY 
      old_reserves.branchcode 
    ) requests_cancelled_before_pulled 
  ON branches.branchcode = requests_cancelled_before_pulled.branchcode LEFT JOIN 
    (SELECT 
      reserves.branchcode, 
      Count(reserves.reserve_id) AS Count_reserve_id 
    FROM 
      reserves JOIN 
      action_logs ON action_logs.object = reserves.reserve_id 
    WHERE 
      Year(reserves.reservedate) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(reserves.reservedate) = Month(Now() - INTERVAL 1 MONTH) AND 
      action_logs.module = 'HOLDS' AND 
      action_logs.action LIKE 'CREAT%' AND 
      action_logs.interface = 'intranet' 
    GROUP BY 
      reserves.branchcode 
    UNION 
    SELECT 
      old_reserves.branchcode, 
      Count(old_reserves.reserve_id) AS Count_reserve_id 
    FROM 
      old_reserves JOIN 
      action_logs ON action_logs.object = old_reserves.reserve_id 
    WHERE 
      Month(old_reserves.reservedate) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(old_reserves.reservedate) = Year(Now() - INTERVAL 1 MONTH) AND 
      action_logs.module = 'HOLDS' AND 
      action_logs.action LIKE 'CREAT%' AND 
      action_logs.interface = 'intranet' 
    GROUP BY 
      old_reserves.branchcode 
    ) requests_placed_staff 
  ON requests_placed_staff.branchcode = branches.branchcode LEFT JOIN 
    (SELECT 
      old_reserves.branchcode, 
      Count(old_reserves.reserve_id) AS Count_reserve_id 
    FROM 
      old_reserves JOIN 
      action_logs ON action_logs.object = old_reserves.reserve_id 
    WHERE 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      old_reserves.found IS NULL AND 
      action_logs.module = 'HOLDS' AND 
      action_logs.action = 'CANCEL' AND 
      action_logs.user = 0 
    GROUP BY 
      old_reserves.branchcode 
    ) requests_expired_unfilled 
  ON requests_expired_unfilled.branchcode = branches.branchcode 
GROUP BY 
  branches.branchname, 
  Coalesce(requests_filled.Count_reserve_id, 0), 
  Coalesce(requests_cancelled_from_hold_shelf.Count_reserve_id, 0), 
  Coalesce(requests_cancelled_in_transit.Count_reserve_id, 0), 
  Coalesce(requests_cancelled_before_pulled.Count_reserve_id, 0), 
  Coalesce(requests_cancelled.Count_reserve_id, 0), 
  requests_expired_unfilled.Count_reserve_id 
ORDER BY 
  Library 

























