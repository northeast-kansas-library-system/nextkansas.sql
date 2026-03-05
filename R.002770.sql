/*
R.002770

----------

Name: GHW - Flexible Circulation and Renewal Count by Shelving Location
Created by: George Williams

----------

Group: Statistics
     -

Created on: 2016-09-12 01:04:34
Modified on: 2025-10-21 09:53:18
Date last run: 2026-01-06 16:41:07

----------

Public: 0
Expiry: 0

----------

notes
"&lt;div class=""reportinfo noprint""&gt; 
&lt;p&gt;Counts circulation (checkouts + renewals) on items checked out between the beginning of the day on DATE1 and the end of the day on DATE2 and groups them by shelving location&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items checked out or renewed between two specified dates (between 12:00 a.m. on DATE1 and 11:59 p.m. on DATE2&lt;/li&gt;
&lt;li&gt;shows items checked out at the specified library&lt;/li&gt;
&lt;li&gt;grouped by item check-out branch&lt;/li&gt;
&lt;li&gt;sorted by item check-out branch and shelving location&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p class=""updated""&gt;SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a ""Recently returned"" shelving location.*  This report falls back to the items' ""Permanent shelving location"" whenever the statistics data shows that the item's shelving location was ""Recently returned.""&lt;/p&gt;
&lt;p&gt;Report created by GHW at the request of LEAVENWRTH so they could track circulation of items on display.&lt;/p&gt;
&lt;p&gt;Items without a shelving location will be recorded as having a shelving location of ""Adult.""&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class=""updated""&gt;Updated on 2021.10.20 to include changes based on the ""Recently returned"" shelving location.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= ""notetags"" style=""display: none;""&gt;#statistics #circulation #permanent_location&lt;/p&gt;
&lt;/div&gt;"

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
      Count(&ast;) AS CKO_RENEW_COUNT,
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

























