/*
R.003533

----------

Name: GHW - Item count by library and/or item type
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-07-26 16:27:18
Modified on: 2021-07-26 23:11:38
Date last run: 2021-09-08 15:49:17

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
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
    '<a class= "clicked" href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=2731&phase=Run+this+report', 
    '&param_name=Item+home+library%7CZBRAN&sql_params=', 
    branchtypes.branchcode, 
    '&param_name=Item+permanent+shelving+location%7CLLOC&sql_params=%25', 
    '&param_name=Item+type%7CLITYPES&sql_params=', 
    branchtypes.itemtype, 
    '&param_name=Item+collection+code%7CLCCODE&sql_params=%25', 
    '&param_name=Enter+first+part+of+call+number+or+a+%25+symbol&sql_params=%25', 
    '&param_name=Not+for+loan+status%7CLNOT_LOAN&sql_params=%25', 
    '&param_name=Item+added+between+date1%7Cdate&sql_params=01%2F01%2F1900&', 'param_name=and+date2%7Cdate&sql_params=12%2F31%2F2099', 
    '&param_name=Item+last+borrowed+between+date1%7Cdate&sql_params=01%2F01%2F1900', 
    '&param_name=and++date2%7Cdate&sql_params=12%2F31%2F2099&', 'param_name=Item+last+seen+between+date1%7Cdate&sql_params=01%2F01%2F1900', 
    '&param_name=and+++date2%7Cdate&sql_params=12%2F31%2F2099', 
    '&param_name=With+X+or+fewer+checkouts%7CZNUMBERS&sql_params=999999999999', 
    '&param_name=Display+checked+out+items%7CZYES_NO&sql_params=%25', 
    '&param_name=Display+lost%2C+missing%2C+and+withdrawn+items%7CZYES_NO&sql_params=%25', 
    '&param_name=With+X+or+more+copies+at+this+library%7CYNUMBER&sql_params=0', 
    '&param_name=With+X+or+more+copies+at+throughout+the+catalog%7CYNUMBER&sql_params=0"', ' target="_blank">', 'Shelflist for these items</a>'
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
      (items.permanent_location LIKE '%ADULT%' OR
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
      items.permanent_location LIKE "%CHILD%"
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
  branchtypes.branchcode LIKE <<Choose your library and leave item type as "All"|branches:all>> AND
  branchtypes.itemtype LIKE <<Or leave library as "All" and choose an item type|itemtypes:all>>
GROUP BY
  branchtypes.branchname,
  branchtypes.description
ORDER BY
  branchtypes.branchname,
  branchtypes.description



