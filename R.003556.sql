/*
R.003556

----------

Name: SANDBOX
Created by: George Williams

----------

Group: -
     -

Created on: 2021-09-07 12:04:47
Modified on: 2025-03-03 14:31:21
Date last run: 2025-03-03 14:31:32

----------

Public: 0
Expiry: 300

----------



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
      Year(reserves.reservedate) = Year(Now() - INTERVAL 2 MONTH) AND 
      Month(reserves.reservedate) = Month(Now() - INTERVAL 2 MONTH) 
    GROUP BY 
      reserves.branchcode 
    UNION 
    SELECT 
      old_reserves.branchcode, 
      Count(old_reserves.reserve_id) AS Count_reserve_id 
    FROM 
      old_reserves 
    WHERE 
      Month(old_reserves.reservedate) = Month(Now() - INTERVAL 2 MONTH) AND 
      Year(old_reserves.reservedate) = Year(Now() - INTERVAL 2 MONTH) 
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
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 2 MONTH) AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 2 MONTH) AND 
      old_reserves.found = 'F' AND 
      action_logs.module = 'HOLDS' AND 
      action_logs.action LIKE "FILL" 
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
      Month(old_reserves.cancellationdate) = Month(Now() - INTERVAL 2 MONTH) AND 
      Year(old_reserves.cancellationdate) = Year(Now() - INTERVAL 2 MONTH) AND 
      (old_reserves.found &lt;&gt; 'F' OR 
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
      Month(old_reserves.cancellationdate) = Month(Now() - INTERVAL 2 MONTH) AND 
      Year(old_reserves.cancellationdate) = Year(Now() - INTERVAL 2 MONTH) AND 
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
      Month(old_reserves.cancellationdate) = Month(Now() - INTERVAL 2 MONTH) AND 
      Year(old_reserves.cancellationdate) = Year(Now() - INTERVAL 2 MONTH) AND 
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
      Month(old_reserves.cancellationdate) = Month(Now() - INTERVAL 2 MONTH) AND 
      Year(old_reserves.cancellationdate) = Year(Now() - INTERVAL 2 MONTH) AND 
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
      Year(reserves.reservedate) = Year(Now() - INTERVAL 2 MONTH) AND 
      Month(reserves.reservedate) = Month(Now() - INTERVAL 2 MONTH) AND 
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
      Month(old_reserves.reservedate) = Month(Now() - INTERVAL 2 MONTH) AND 
      Year(old_reserves.reservedate) = Year(Now() - INTERVAL 2 MONTH) AND 
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
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 2 MONTH) AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 2 MONTH) AND 
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

























