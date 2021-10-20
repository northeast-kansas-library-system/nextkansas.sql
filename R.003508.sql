/*
R.003508

----------

Name: GHW - Request cancellation turnaround time
Created by: George H Williams

----------

Group: Statistics
     -

Created on: 2021-05-20 15:59:21
Modified on: 2021-05-20 18:29:47
Date last run: 2021-06-16 16:51:24

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Counts delay in days between a request's waiting date and the date the request is cancelled</p>
<ul><li>Only shows requests that were cancelled in the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped and sorted by the library name and the number of days</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report will only requests that were waiting for pickup - if the request is cancelled before the item makes it to the hold shelf, it will not be counted.</p>
<p></p>
</div>

----------
*/



SELECT 
  branches.branchcode, 
  cnx_turnaround.CNX_DELAY_DAYS, 
  Coalesce(cnx_turnaround.ITEMS_CNX, 0) AS ITEMS_CNX 
FROM 
  branches LEFT JOIN 
  (SELECT 
      old_reserves.branchcode, 
      DateDiff( 
        old_reserves.cancellationdate, 
        old_reserves.waitingdate 
      ) 
      CNX_DELAY_DAYS, 
      Count(old_reserves.reserve_id) AS ITEMS_CNX 
    FROM 
      old_reserves 
    WHERE 
      Month(old_reserves.cancellationdate) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(old_reserves.cancellationdate) = Year(Now() - INTERVAL 1 MONTH) AND 
      old_reserves.waitingdate IS NOT NULL 
    GROUP BY 
      old_reserves.branchcode, 
      DateDiff( 
        old_reserves.cancellationdate, 
        old_reserves.waitingdate 
      ) 
  ) 
  cnx_turnaround 
  ON cnx_turnaround.branchcode = branches.branchcode 
WHERE 
  branches.branchcode LIKE <<Choose your library|LBRANCH>> 
GROUP BY 
  branches.branchcode, 
  cnx_turnaround.CNX_DELAY_DAYS

























