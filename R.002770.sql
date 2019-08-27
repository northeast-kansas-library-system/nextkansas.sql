/*
R.002770

----------

Name: GHW - Flexible Circulation and Renewal Count by Shelving Location
Created by: George H Williams

----------

Group: Statistics
     -

Created on: 2016-09-12 01:04:34
Modified on: 2019-07-15 15:35:50
Date last run: 2019-07-15 16:50:36

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Counts circulation (checkouts + renewals) on items checked out between DATE1 and DATE2 and groups them by shelving location</p>
<ul><li>Shows items checked out or renewed between two specified dates (between 12:00 a.m. on DATE1 and 11:59 p.m. on DATE2</li>
<li>shows items checked out at the specified library</li>
<li>grouped by item check-out branch</li>
<li>sorted by item check-out branch and shelving location</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Location data is based on the shelving location of the item at the time the report was run - not the time when the item circulated.</p>
<p>Report created by GHW at the request of LEAVENWRTH so they could track circulation of items on display.</p>
<p>Items without a shelving location will be recorded as having a shelving location of "Processing Center."</p>
<p></p>
<p>Updated on 2019.07.15 to include changes based on additional shelving locations.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2770&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  branches.branchname as BRANCHNAME,
  branches.lib as SHELVING_LOCATION,
  Coalesce(Sum(statisticss.CKO_RENEW_COUNT), "-") AS CKO_RENEW_COUNT
FROM
  (
    SELECT
      branches.branchcode,
      branches.branchname,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category
    FROM
      branches,
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) branches
  LEFT JOIN (
    SELECT
      statistics.branch,
      Count(*) AS CKO_RENEW_COUNT,
      Coalesce(statistics.location, "ADULT") AS location
    FROM
      statistics
    WHERE
      statistics.datetime BETWEEN <<Between start date|date>> AND (<<and end date|date>> + INTERVAL 1 DAY) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      statistics.branch,
      Coalesce(statistics.location, "ADULT")
  ) statisticss
    ON statisticss.branch = branches.branchcode AND
      statisticss.location = branches.authorised_value
WHERE
  branches.branchcode LIKE <<Choose check-out library|LBRANCH>>
GROUP BY
  branches.branchname,
  branches.lib



