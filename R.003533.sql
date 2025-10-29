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
Date last run: 2025-07-15 17:11:08

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Item count by item type</p>
<ul><li>Counts items currently in the collection</li>
<li>At the library you specify - and/or - with the item type you specify</li>
<li>grouped and sorted by library name and item type</li>
<li>links to report 2731 to generate a shelflist for the items being counted</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Non-standard shelving locations are counted as "Adult" locations.</p>
<p>Items with blank item types are counted as "(Unclassified)."</p>
<p></p>
<p><strong>Replaces all other item count by item type reports.</strong></p>
<ul>
  <li>1124 - Collection size by Item Type</li>
  <li>1179 - Entire Collection Size by IType</li>
  <li>1413 - Collection Size by Item Type & Location (per branch)</li>
  <li>1811 - Itemtypes in use at Prairie Hills Schools</li>
</ul>
<p class= "notetags" style="display: none;">#ultimate #itemcount #itype #itemtype item count type</p>
</div>

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

























