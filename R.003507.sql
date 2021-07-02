/*
R.003507

----------

Name: GHW - Request turnaround time
Created by: George H Williams

----------

Group: Statistics
     -

Created on: 2021-05-20 15:40:51
Modified on: 2021-05-20 18:28:43
Date last run: 2021-05-23 23:43:35

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Counts delay in days between a request's waiting date and the date it's checked out</p>
<ul><li>Only shows requests that were picked up in the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped and sorted by the library name and the number of days</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report will only work if the system preference "HoldsLog" is set to "Log."</p>
<p></p>
</div>

----------
*/

SELECT 
  branches.branchcode, 
  ckoturnaround.PICKUP_DELAY_DAYS, 
  Coalesce(ckoturnaround.ITEMS_PICKED_UP, 0) AS ITEMS_PICKED_UP_COUNT 
FROM 
  branches LEFT JOIN 
  (SELECT 
      old_reserves.branchcode, 
      DateDiff( 
        ckodates.cko_date, 
        Coalesce(old_reserves.waitingdate, CAST(old_reserves.timestamp AS DATE)) 
      ) AS PICKUP_DELAY_DAYS, 
      Count(old_reserves.reserve_id) AS ITEMS_PICKED_UP 
    FROM 
      old_reserves JOIN 
      (SELECT 
          action_logs.action_id, 
          action_logs.timestamp, 
          action_logs.user, 
          action_logs.module, 
          action_logs.action, 
          action_logs.object, 
          action_logs.info, 
          action_logs.interface, 
          CAST(action_logs.timestamp AS DATE) AS cko_date 
        FROM 
          action_logs 
        WHERE 
          action_logs.module = 'HOLDS' AND 
          Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
          Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
          action_logs.action = Concat('D', 'ELETE') 
      ) ckodates 
      ON ckodates.object = old_reserves.reserve_id 
    WHERE 
      old_reserves.found = 'F'
    GROUP BY 
      old_reserves.branchcode, 
      DateDiff( 
        ckodates.cko_date, 
        Coalesce(old_reserves.waitingdate, CAST(old_reserves.timestamp AS DATE)) 
      ) 
  ) ckoturnaround ON 
      ckoturnaround.branchcode = branches.branchcode 
WHERE 
  branches.branchcode LIKE <<Choose your library|LBRANCH>> 
GROUP BY 
  branches.branchcode, 
  ckoturnaround.PICKUP_DELAY_DAYS, 
  ITEMS_PICKED_UP_COUNT 



