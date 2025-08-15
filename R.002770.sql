/*
R.002770

----------

Name: GHW - Flexible Circulation and Renewal Count by Shelving Location
Created by: George Williams

----------

Group: Statistics
     -

Created on: 2016-09-12 01:04:34
Modified on: 2024-01-17 11:36:40
Date last run: 2025-07-22 09:50:50

----------

Public: 0
Expiry: 0

----------

 
Counts circulation (checkouts + renewals) on items checked out between the beginning of the day on DATE1 and the end of the day on DATE2 and groups them by shelving location
Shows items checked out or renewed between two specified dates (between 12:00 a.m. on DATE1 and 11:59 p.m. on DATE2
shows items checked out at the specified library
grouped by item check-out branch
sorted by item check-out branch and shelving location

Notes:
SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."
Report created by GHW at the request of LEAVENWRTH so they could track circulation of items on display.
Items without a shelving location will be recorded as having a shelving location of "Adult."

Updated on 2021.10.20 to include changes based on the "Recently returned" shelving location.

#statistics #circulation #permanent_location


----------
*/



SELECT
  branches.branchname AS BRANCHNAME,
  branches.lib AS SHELVING_LOCATION,
  Coalesce(Sum(statisticss.CKO_RENEW_COUNT), 0) AS CKO_RENEW_COUNT
FROM
  (SELECT
      branches.branchcode,
      branches.branchname,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category
    FROM
      branches,
      authorised_values
    WHERE
      authorised_values.category = 'LOC') branches LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS CKO_RENEW_COUNT,
      If(
        Coalesce(statistics.location, "L_AD") = "CART",
        items.permanent_location, 
        Coalesce(statistics.location, "L_AD")
      ) AS
      location
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      statistics.datetime BETWEEN 
        &lt;&gt; AND 
        (&lt;&gt; + INTERVAL 1 DAY) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      statistics.branch,
      Coalesce(statistics.location, "L_AD")) statisticss ON
      statisticss.branch = branches.branchcode AND
      statisticss.location = branches.authorised_value
WHERE
  branches.branchcode LIKE &lt;&gt;
GROUP BY
  branches.branchname,
  branches.lib

























