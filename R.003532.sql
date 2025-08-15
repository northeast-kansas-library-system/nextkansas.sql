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
Date last run: 2025-07-01 08:44:35

----------

Public: 0
Expiry: 300

----------

 
Item count by collection code
Counts items currently in the collection
At the library you specify - or with the collection code you specify
grouped and sorted by library name and collection code
links to report 2731 to generate a shelflist for the items being counted

Notes:

Non-standard shelving locations are counted as "Adult" locations.
Items with blank collection codes are counted as "(Unclassified)."

Replaces all other item count by collection code reports.

  716 - Count of Yearly New items added by CCode
  808 - Collection size by Collection Code & Location (per branch)
  1666 - Collection size by Collection Code
  2970 - GHW - Collection Statistics - Items at a library
  3172 - GHW - Collection code count by Library
  3180 - GHW - CCODE count by library

#ultimate #itemcount #ccode item count collection code ccode


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

























