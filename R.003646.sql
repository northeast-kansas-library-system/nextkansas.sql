/*
R.003646

----------

Name: GHW - Circulation and renewal count by library, location, item type, and collection code.
Created by: George Williams

----------

Group: -
     -

Created on: 2022-02-06 01:06:29
Modified on: 2024-01-17 11:29:21
Date last run: 2026-01-14 14:36:02

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Circulation and renewal count by library, location, item type, and collection code.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows circulation in the month you specify (limited to the previous 25 months)&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped by circulating library, location, item type, and collection code&lt;/li&gt;
&lt;li&gt;sorted by circulating library, item type, and collection code&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Replaces reports:&lt;/p&gt;
&lt;ul&gt;
&lt;li&gt;1930&lt;/li&gt;
&lt;li&gt;3165&lt;/li&gt;
&lt;/ul&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;#circ_count_by_library #circ_count_by_itype #circ_count_by_ccode #circ_count_by_location&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  branches.branchname,
  itemtypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  Coalesce(Sum(DISTINCT all_counts.count), 0) AS ALL_CKO_RENEW,
  Coalesce(Sum(DISTINCT adult.count), 0) AS ADULT,
  Coalesce(Sum(DISTINCT children.count), 0) AS CHILDRENS,
  Coalesce(Sum(DISTINCT young_adult.count), 0) AS YA,
  Coalesce(Sum(DISTINCT all_counts.count), 0) - 
    (Coalesce(Sum(DISTINCT adult.count), 0) +
    Coalesce(Sum(DISTINCT children.count), 0) +
    Coalesce(Sum(DISTINCT young_adult.count), 0)
  ) AS OTHER
FROM
  branches JOIN
  (SELECT
     statistics.branch,
     statistics.itemtype,
     statistics.ccode,
     Count(&ast;) AS count
   FROM
     statistics
   WHERE
     statistics.branch LIKE &lt;&gt; AND
     statistics.type IN ('issue', 'renew') AND
     Year(statistics.datetime) = &lt;&gt; AND
     Month(statistics.datetime)= &lt;&gt; 
   GROUP BY
     statistics.branch,
     statistics.itemtype,
     statistics.ccode) all_counts ON all_counts.branch = branches.branchcode
  LEFT JOIN
  (SELECT
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) AS LOC,
     statistics.itemtype,
     statistics.ccode,
     Count(&ast;) AS count
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber LEFT JOIN
     deleteditems ON deleteditems.itemnumber = statistics.itemnumber
   WHERE
     statistics.branch LIKE &lt;&gt; AND
     statistics.type IN ('issue', 'renew') AND
     Month(statistics.datetime)= &lt;&gt; AND
     Year(statistics.datetime) = &lt;&gt; AND
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) LIKE "%AD%"
   GROUP BY
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ),
     statistics.itemtype,
     statistics.ccode) adult ON adult.branch = all_counts.branch AND
      adult.ccode = all_counts.ccode AND
      adult.itemtype = all_counts.itemtype LEFT JOIN
  (SELECT
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) AS LOC,
     statistics.itemtype,
     statistics.ccode,
     Count(&ast;) AS count
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber LEFT JOIN
     deleteditems ON deleteditems.itemnumber = statistics.itemnumber
   WHERE
     statistics.branch LIKE &lt;&gt; AND
     statistics.type IN ('issue', 'renew') AND
     Month(statistics.datetime)= &lt;&gt; AND
     Year(statistics.datetime) = &lt;&gt; AND
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) LIKE "%CHILD%"
   GROUP BY
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ),
     statistics.itemtype,
     statistics.ccode) children ON children.branch = all_counts.branch AND
      children.itemtype = all_counts.itemtype AND
      children.ccode = all_counts.ccode LEFT JOIN
  (SELECT
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) AS LOC,
     statistics.itemtype,
     statistics.ccode,
     Count(&ast;) AS count
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber LEFT JOIN
     deleteditems ON deleteditems.itemnumber = statistics.itemnumber
   WHERE
     statistics.branch LIKE &lt;&gt; AND
     statistics.type IN ('issue', 'renew') AND
     Month(statistics.datetime)= &lt;&gt; AND
     Year(statistics.datetime) = &lt;&gt; AND
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) LIKE "%YA%"
   GROUP BY
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ),
     statistics.itemtype,
     statistics.ccode) young_adult ON young_adult.branch = all_counts.branch AND
      young_adult.itemtype = all_counts.itemtype AND
      young_adult.ccode = all_counts.ccode LEFT JOIN
  itemtypes ON itemtypes.itemtype = all_counts.itemtype LEFT JOIN
  (SELECT
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib,
     authorised_values.lib_opac
   FROM
     authorised_values
   WHERE
     authorised_values.category = 'CCODE') ccodes 
     ON ccodes.authorised_value = all_counts.ccode
GROUP BY
  branches.branchname,
  itemtypes.description,
  ccodes.lib
ORDER BY
  branches.branchname,
  ITYPE,
  CCODE

























