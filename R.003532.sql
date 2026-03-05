/*
R.003532

----------

Name: GHW - Item count by library and/or collection code
Created by: George Williams

----------

Group: -
     -

Created on: 2021-07-26 15:37:59
Modified on: 2024-01-17 11:28:04
Date last run: 2025-11-20 14:48:02

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Item count by collection code&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Counts items currently in the collection&lt;/li&gt;
&lt;li&gt;At the library you specify - or with the collection code you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by library name and collection code&lt;/li&gt;
&lt;li&gt;links to report 2731 to generate a shelflist for the items being counted&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Non-standard shelving locations are counted as "Adult" locations.&lt;/p&gt;
&lt;p&gt;Items with blank collection codes are counted as "(Unclassified)."&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;strong&gt;Replaces all other item count by collection code reports.&lt;/strong&gt;&lt;/p&gt;
&lt;ul&gt;
  &lt;li&gt;716 - Count of Yearly New items added by CCode&lt;/li&gt;
  &lt;li&gt;808 - Collection size by Collection Code & Location (per branch)&lt;/li&gt;
  &lt;li&gt;1666 - Collection size by Collection Code&lt;/li&gt;
  &lt;li&gt;2970 - GHW - Collection Statistics - Items at a library&lt;/li&gt;
  &lt;li&gt;3172 - GHW - Collection code count by Library&lt;/li&gt;
  &lt;li&gt;3180 - GHW - CCODE count by library&lt;/li&gt;
&lt;/ul&gt;
&lt;p class= "notetags" style="display: none;"&gt;#ultimate #itemcount #ccode item count collection code ccode&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT 
  branchccodes.branchname, 
  branchccodes.lib AS "COLLECTION CODE", 
  itemss.Count_itemnumber AS "TOTAL ITEMS", 
  adultitems.Count_itemnumber AS "ADULT ITEMS", 
  juvenileitems.Count_itemnumber AS "JUVENILE ITEMS", 
  yaitems.Count_itemnumber AS "YOUNG ADULT ITEMS", 
  If(
    branchlimits.branchcode IS NULL, 
    "", 
    "Yes"
  ) AS "THIS LIB CAN USE/MAKE", 
  Concat( 
    '', 
    'Shelflist for these items' 
  ) AS SHELFLIST 
FROM 
  (
    SELECT 
      branches.branchcode, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      branches.branchname, 
      authorised_values.id 
    FROM 
      branches, 
      authorised_values 
    WHERE 
      authorised_values.category = 'CCODE'
  ) branchccodes 
  LEFT JOIN 
  (
    SELECT 
      items.homebranch, 
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    GROUP BY 
      items.homebranch, 
      If(items.ccode IS NULL, "XXX", items.ccode)
  ) itemss 
  ON itemss.homebranch = branchccodes.branchcode 
  AND itemss.ccode = branchccodes.authorised_value 
  LEFT JOIN 
  (
    SELECT 
      items.homebranch, 
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      (items.permanent_location LIKE '%AD%' OR 
        items.permanent_location = 'CART' OR 
        items.permanent_location = 'CATALOGING' OR 
        items.permanent_location = 'PROC' OR 
        items.permanent_location IS NULL) 
    GROUP BY 
      items.homebranch, 
      If(items.ccode IS NULL, "XXX", items.ccode)
  ) adultitems 
  ON adultitems.homebranch = branchccodes.branchcode 
  AND adultitems.ccode = branchccodes.authorised_value 
  LEFT JOIN 
  ( 
    SELECT 
      items.homebranch, 
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      items.permanent_location LIKE "%JU%" 
    GROUP BY 
      items.homebranch, 
      If(items.ccode IS NULL, "XXX", items.ccode)
  ) juvenileitems 
  ON juvenileitems.homebranch = branchccodes.branchcode 
  AND juvenileitems.ccode = branchccodes.authorised_value 
  LEFT JOIN 
  (
    SELECT 
      items.homebranch, 
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      items.permanent_location LIKE "%YA%" 
    GROUP BY 
      items.homebranch, 
      If(items.ccode IS NULL, "XXX", items.ccode)
  ) yaitems 
  ON yaitems.homebranch = branchccodes.branchcode 
  AND yaitems.ccode = branchccodes.authorised_value 
  LEFT JOIN 
  (
    SELECT 
      authorised_values_branches.av_id, 
      authorised_values_branches.branchcode 
    FROM 
      authorised_values_branches
  ) branchlimits 
  ON branchlimits.av_id = branchccodes.id 
  AND branchlimits.branchcode = branchccodes.branchcode 
WHERE 
  branchccodes.branchcode LIKE &lt;&gt; AND 
  branchccodes.authorised_value LIKE &lt;&gt; 
GROUP BY 
  branchccodes.branchcode, 
  branchccodes.authorised_value 
ORDER BY 
  branchccodes.branchname, 
  branchccodes.lib 
LIMIT 500 

























