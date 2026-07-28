/*
R.003471

----------

Name: GHW - Replacement cost of library materials by Collection Code
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-03 15:29:51
Modified on: 2025-03-26 01:12:58
Date last run: 2026-07-21 15:24:45

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Shows replacement cost of collection</p>
<ul><li>Results are based on materials currently in the catalog</li>
<li>at the library, shelving location, and collection code you specify</li>
<li>grouped and sorted by library, shelving location, and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Updated in March of 2025 to link to 3879 instead of 2731.</p>
<p>This report will only return values based on the "Cost, replacement price" field in the item record (Marc subfield 952$v).  If no value is entered in this field, the value for that item will be $0.00.  If that field has been incorrectly entered, that incorrect value will be a part of the total.</p><br />
<p>Report 3362 can show you items at your library with a blank or 0 value "Cost, replacement price" field: <a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3362&phase=Run%20this%20report">click here to run report 3362</a></p>

<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3471&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">tag goes here</p>
</div>

----------
*/



SELECT
  branches.branchname AS LIBRARY,
  locs.lib AS SHELVING_LOCATION,
  ccodes.lib AS COLLECTION_CODE,
  Count(items.itemnumber) AS ITEM_COUNT,
  Coalesce(Sum(items.replacementprice), 0) AS REPLACEMENT_COST,
  Concat( 
    '<a class="btn btn-default"', 
    'href=\"', 
    
'/cgi-bin/koha/reports/guided_reports.pl?id=3879',

'&param_name=Item+home+library%7CZBRAN&sql_params=',

items.homebranch, 

'&param_name=Item+permanent+shelving+location%7CLLOC&sql_params=',

items.permanent_location,

'&param_name=Item+type%7CLITYPES&sql_params=',

'%25',

'&param_name=Item+collection+code%7CLCCODE&sql_params=',

items.ccode,

'&param_name=Enter+first+part+of+call+number+or+a+%25+symbol&sql_params=',

'%25',

'&param_name=Not+for+loan+status%7CLNOT_LOAN&sql_params=',

'%28.*%3F%29',

'&param_name=Item+added+between+date1%7Cdate&sql_params=',

'2000-01-01',

'&param_name=and-date2%7Cdate&sql_params=',

'9999-12-31',

'&param_name=Item+last+borrowed+between+date1%7Cdate&sql_params=',

'2000-01-01',

'&param_name=and--date2%7Cdate&sql_params=',

'9999-12-31',

'&param_name=Item+last+seen+between+date1%7Cdate&sql_params=',

'2000-01-01',

'&param_name=and---date2%7Cdate&sql_params=',

'9999-12-31',

'&param_name=Display+lost%2C+missing%2C+and+withdrawn+items%7CZYES_NO&sql_params=',

'%25',

'&param_name=Damaged+status%7CDAMAGED%3Aall&sql_params=',

'%25',

'&param_name=Lost+status%7CLLOST&sql_params=',

'%25',

'&param_name=Withdrawn+status%7CWITHDRAWN%3Aall&sql_params=',

'%25',

'&param_name=With+X+or+fewer+checkouts%7CZNUMBERS&sql_params=',

'999999999999',

'&param_name=Display+checked+out+items%7CZYES_NO&sql_params=',

'%25',

'&param_name=With+X+or+more+copies+at+this+library%7CYNUMBER&sql_params=',

'0',

'&param_name=With+X+or+more+copies+at+throughout+the+catalog%7CYNUMBER&sql_params=',

'0&op=run"' 
    
    ' target="_blank">', 
    'Shelflist for these items</a>' 
  ) AS SHELFLIST 
FROM
  items 
  LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode'
  ) ccodes 
    ON ccodes.authorised_value = Coalesce(items.ccode, "XXX") 
  LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc'
  ) locs 
    ON locs.authorised_value = Coalesce(items.permanent_location, "PROC") 
  JOIN branches 
    ON items.homebranch = branches.branchcode
WHERE
  items.homebranch LIKE <<Choose your library|ZBRAN>> AND
  items.permanent_location LIKE <<Choose a permanent shelving location|LLOC>> AND
  items.ccode LIKE <<Choose a collection code|LCCODE>>
GROUP BY
  branches.branchname,
  locs.lib,
  ccodes.lib

























