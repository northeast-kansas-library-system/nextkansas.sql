/*
R.002975

----------

Name: GHW -  9906 Monthly requests
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2017-07-11 11:52:53
Modified on: 2021-04-30 11:20:01
Date last run: 2021-05-01 00:30:02

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Statistics on requests</p>
<ul><li>Shows statistics for the previous calendar month</li>
<li>at all Next Search Catalog libraries</li>
<li>grouped and sorted by library code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report was updated on January 3, 2020, to improve accuracy in the FILLED_LM column.</p>
<p></p>
<p>PLACED_LM = the number of requests that were placed in the previous calendar month.</p>
<p></p>
<p>FILLED_LM = the number of requests that were checked out to library patrons in the previous calendar month - regardless of when the requests were initially placed.</p>
<p></p>
<p>CNX_FROM_HOLD_SHELF_LM = the number of items that were waiting for a patron to pick them up at the time the request was cancelled during the previous calendar month - regardless of when the requests were initially placed.  These requests could only have been cancelled by staff.</p>
<p></p>
<p>CNX_IN_TRASIT_LM = the number of items that were in transit from one library to its destination at the time the request was cancelled during the previous calendar month - regardless of when the requests were initially placed.  These requests could only have been cancelled by staff.</p>
<p></p>
<p>CNX_BEFORE_ACTION_LM = the number of items that were cancelled before any item was shipped or waiting or possibly even pulled from the shelf to fill the requests during the previous calendar month - regardless of when the requests were initially placed.  These requests could have been cancelled by staff or by patrons.</p>
<p></p>
<p>CNX_TOTAL_LM = the total number of items that were cancelled during the previous calendar month - regardless of when the requests were initially placed.</p>
<p></p>
<p>PLACED_BY_STAFF= the total number of requests placed last month that were created by staff members.</p>
<p></p>
<p>PLACED_BY_PATRON = the total number of requests placed by patrons via the OPAC.</p>
<p></p>
<p style="display: none;">MNTHLY</p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=2975">Click here to download as a csv file</a></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2975&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>






----------
*/

SELECT
  branches.branchcode,
  Sum(Coalesce(requests_placed.Count_reserve_id, 0)) AS PLACED_LM,
  Coalesce(requests_filled.Count_reserve_id, 0) AS FILLED_LM,
  Coalesce(requests_cancelled_from_hold_shelf.Count_reserve_id, 0) AS CNX_FROM_HOLD_SHELF_LM,
  Coalesce(requests_cancelled_in_transit.Count_reserve_id, 0) AS CNX_IN_TRASIT_LM,
  Coalesce(requests_cancelled_before_pulled.Count_reserve_id, 0) AS CNX_BEFORE_ACTION_LM,
  Coalesce(requests_cancelled.Count_reserve_id, 0) AS CNX_TOTAL_LM,
  Coalesce(requests_expired_unfilled.Count_reserve_id, 0) AS EXPIRED_LM,
  Sum(Coalesce(requests_placed_staff.Count_reserve_id, 0)) AS PLACED_BY_STAFF,
  (Sum(Coalesce(requests_placed.Count_reserve_id, 0)) - Sum(Coalesce(requests_placed_staff.Count_reserve_id, 0))) AS PLACED_BY_PATRON
FROM
  branches
  LEFT JOIN (
    SELECT
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
    ON branches.branchcode = requests_placed.branchcode
  LEFT JOIN (
    SELECT
      old_reserves.branchcode,
      Count(old_reserves.reserve_id) AS Count_reserve_id
    FROM
      old_reserves
      JOIN action_logs
        ON action_logs.object = old_reserves.reserve_id
    WHERE
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      old_reserves.found = 'F' AND
      action_logs.module = 'HOLDS' AND
      action_logs.action LIKE "DEL%"
    GROUP BY
      old_reserves.branchcode
  ) requests_filled
    ON branches.branchcode = requests_filled.branchcode
  LEFT JOIN (
    SELECT
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
    ON branches.branchcode = requests_cancelled.branchcode
  LEFT JOIN (
    SELECT
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
    ON branches.branchcode = requests_cancelled_in_transit.branchcode
  LEFT JOIN (
    SELECT
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
    ON branches.branchcode = requests_cancelled_from_hold_shelf.branchcode
  LEFT JOIN (
    SELECT
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
    ON branches.branchcode = requests_cancelled_before_pulled.branchcode
  LEFT JOIN (
    SELECT
      reserves.branchcode,
      Count(reserves.reserve_id) AS Count_reserve_id
    FROM
      reserves
      JOIN action_logs
        ON action_logs.object = reserves.reserve_id
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
      old_reserves
      JOIN action_logs
        ON action_logs.object = old_reserves.reserve_id
    WHERE
      Month(old_reserves.reservedate) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(old_reserves.reservedate) = Year(Now() - INTERVAL 1 MONTH) AND
      action_logs.module = 'HOLDS' AND
      action_logs.action LIKE 'CREAT%' AND
      action_logs.interface = 'intranet'
    GROUP BY
      old_reserves.branchcode
  ) requests_placed_staff
    ON requests_placed_staff.branchcode = branches.branchcode
  LEFT JOIN (
    SELECT
      old_reserves.branchcode,
      Count(old_reserves.reserve_id) AS Count_reserve_id
    FROM
      old_reserves
      JOIN action_logs
        ON action_logs.object = old_reserves.reserve_id
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
  branches.branchcode,
  Coalesce(requests_filled.Count_reserve_id, 0),
  Coalesce(requests_cancelled_from_hold_shelf.Count_reserve_id, 0),
  Coalesce(requests_cancelled_in_transit.Count_reserve_id, 0),
  Coalesce(requests_cancelled_before_pulled.Count_reserve_id, 0),
  Coalesce(requests_cancelled.Count_reserve_id, 0),
  requests_expired_unfilled.Count_reserve_id



