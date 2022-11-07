/*
R.003532

----------

Name: GHW - Item count by library and/or collection code
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-07-26 15:37:59
Modified on: 2021-07-26 23:07:06
Date last run: 2022-10-25 12:05:33

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Item count by collection code</p>
<ul><li>Counts items currently in the collection</li>
<li>At the library you specify - or with the collection code you specify</li>
<li>grouped and sorted by library name and collection code</li>
<li>links to report 2731 to generate a shelflist for the items being counted</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Non-standard shelving locations are counted as "Adult" locations.</p>
<p>Items with blank collection codes are counted as "(Unclassified)."</p>
<p></p>
<p><strong>Replaces all other item count by collection code reports.</strong></p>
<ul>
  <li>716 - Count of Yearly New items added by CCode</li>
  <li>808 - Collection size by Collection Code & Location (per branch)</li>
  <li>1666 - Collection size by Collection Code</li>
  <li>2970 - GHW - Collection Statistics - Items at a library</li>
  <li>3172 - GHW - Collection code count by Library</li>
  <li>3180 - GHW - CCODE count by library</li>
</ul>
<p class= "notetags" style="display: none;">#ultimate #itemcount #ccode item count collection code ccode</p>
</div>

----------
*/



SELECT
  branchccodes.branchname,
  branchccodes.lib AS "COLLECTION CODE",
  itemss.Count_itemnumber AS "TOTAL ITEMS",
  adultitems.Count_itemnumber AS "ADULT ITEMS",
  juvenileitems.Count_itemnumber AS "JUVENILE ITEMS",
  yaitems.Count_itemnumber AS "YOUNG ADULT ITEMS",
  If(branchlimits.branchcode IS NULL, "", "Yes") AS "THIS LIB CAN USE/MAKE",
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=2731&phase=Run+this+report', 
    '&param_name=Item+home+library%7CZBRAN&sql_params=', 
    branchccodes.branchcode, 
    '&param_name=Item+permanent+shelving+location%7CLLOC&sql_params=%25', 
    '&param_name=Item+type%7CLITYPES&sql_params=%25', 
    '&param_name=Item+collection+code%7CLCCODE&sql_params=', 
    branchccodes.authorised_value, 
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
      authorised_values.authorised_value,
      authorised_values.lib,
      branches.branchname,
      authorised_values.id
    FROM
      branches,
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') branchccodes LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) itemss ON itemss.homebranch =
      branchccodes.branchcode AND
      itemss.ccode = branchccodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
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
      If(items.ccode IS NULL, "XXX", items.ccode)) adultitems ON
      adultitems.homebranch = branchccodes.branchcode AND
      adultitems.ccode = branchccodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE "%CHILD%"
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) juvenileitems ON
      juvenileitems.homebranch = branchccodes.branchcode AND
      juvenileitems.ccode = branchccodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE "%YA%"
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) yaitems ON
      yaitems.homebranch = branchccodes.branchcode AND
      yaitems.ccode = branchccodes.authorised_value LEFT JOIN
  (SELECT
      authorised_values_branches.av_id,
      authorised_values_branches.branchcode
    FROM
      authorised_values_branches) branchlimits ON branchlimits.av_id =
      branchccodes.id AND
      branchlimits.branchcode = branchccodes.branchcode
WHERE
  branchccodes.branchcode LIKE <<Choose your library and leave collection code as "All"|branches:all>> AND
  branchccodes.authorised_value LIKE <<Or leave library as "All" and choose a collection code|CCODE:all>>
GROUP BY
  branchccodes.branchcode,
  branchccodes.authorised_value
ORDER BY
  branchccodes.branchname,
  branchccodes.lib

























