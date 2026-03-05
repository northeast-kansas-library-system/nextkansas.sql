/*
R.003533

----------

Name: GHW - Item count by library and/or item type
Created by: George Williams

----------

Group: -
     -

Created on: 2021-07-26 16:27:18
Modified on: 2024-01-17 11:28:08
Date last run: 2025-11-24 11:58:00

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Item count by item type&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Counts items currently in the collection&lt;/li&gt;
&lt;li&gt;At the library you specify - and/or - with the item type you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by library name and item type&lt;/li&gt;
&lt;li&gt;links to report 2731 to generate a shelflist for the items being counted&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Non-standard shelving locations are counted as "Adult" locations.&lt;/p&gt;
&lt;p&gt;Items with blank item types are counted as "(Unclassified)."&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;strong&gt;Replaces all other item count by item type reports.&lt;/strong&gt;&lt;/p&gt;
&lt;ul&gt;
  &lt;li&gt;1124 - Collection size by Item Type&lt;/li&gt;
  &lt;li&gt;1179 - Entire Collection Size by IType&lt;/li&gt;
  &lt;li&gt;1413 - Collection Size by Item Type & Location (per branch)&lt;/li&gt;
  &lt;li&gt;1811 - Itemtypes in use at Prairie Hills Schools&lt;/li&gt;
&lt;/ul&gt;
&lt;p class= "notetags" style="display: none;"&gt;#ultimate #itemcount #itype #itemtype item count type&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT 
  branchtypes.branchname, 
  branchtypes.description AS "ITEM TYPE", 
  itemss.Count_itemnumber AS "TOTAL ITEMS", 
  adultitems.Count_itemnumber AS "ADULT ITEMS", 
  juvenileitems.Count_itemnumber AS "JUVENILE ITEMS", 
  yaitems.Count_itemnumber AS "YOUNG ADULT ITEMS", 
  Concat( 
    '', 
    'Shelflist for these items' 
  ) AS SHELFLIST 
FROM 
  (SELECT 
      branches.branchcode, 
      branches.branchname, 
      itemtypes.itemtype, 
      itemtypes.description 
    FROM 
      itemtypes, 
      branches) branchtypes LEFT JOIN 
  (SELECT 
      items.homebranch, 
      If(items.itype IS NULL, "XXX", items.itype) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    GROUP BY 
      items.homebranch, 
      If(items.itype IS NULL, "XXX", items.itype)) itemss ON itemss.homebranch = 
      branchtypes.branchcode AND 
      itemss.itype = branchtypes.itemtype LEFT JOIN 
  (SELECT 
      items.homebranch, 
      If(items.itype IS NULL, "XXX", items.itype) AS itype, 
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
      If(items.itype IS NULL, "XXX", items.itype)) adultitems ON 
      adultitems.homebranch = branchtypes.branchcode AND 
      adultitems.itype = branchtypes.itemtype LEFT JOIN 
  (SELECT 
      items.homebranch, 
      If(items.itype IS NULL, "XXX", items.itype) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      items.permanent_location LIKE "%JU%" 
    GROUP BY 
      items.homebranch, 
      If(items.itype IS NULL, "XXX", items.itype)) juvenileitems ON 
      juvenileitems.homebranch = branchtypes.branchcode AND 
      juvenileitems.itype = branchtypes.itemtype LEFT JOIN 
  (SELECT 
      items.homebranch, 
      If(items.itype IS NULL, "XXX", items.itype) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      items.permanent_location LIKE "%YA%" 
    GROUP BY 
      items.homebranch, 
      If(items.itype IS NULL, "XXX", items.itype)) yaitems ON 
      yaitems.homebranch = branchtypes.branchcode AND 
      yaitems.itype = branchtypes.itemtype 
WHERE 
  branchtypes.branchcode LIKE &lt;&gt; AND 
  branchtypes.itemtype LIKE &lt;&gt; 
GROUP BY 
  branchtypes.branchname, 
  branchtypes.description 
ORDER BY 
  branchtypes.branchname, 
  branchtypes.description 
LIMIT 500 

























