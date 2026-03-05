/*
R.003729

----------

Name: Replace 3472
Created by: George Williams

----------

Group: -
     -

Created on: 2023-05-26 15:52:27
Modified on: 2023-05-26 16:23:44
Date last run: 2025-03-20 09:05:05

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches.branchname AS LIBRARY,
  locs.lib AS SHELVING_LOCATION,
  itypess.description AS ITEM_TYPE,
  Count(items.itemnumber) AS ITEM_COUNT,
  Coalesce(Sum(items.replacementprice), 0) AS REPLACEMENT_COST,
  Concat( 
    '<a class="btn btn-default"', 
    'href=\"', 
    '/cgi-bin/koha/reports/guided_reports.pl?reports=2731&', 
    'phase=Run+this+report&', 
    'param_name=Item+home+library%7CZBRAN&', 
    'sql_params=', 
    items.homebranch, 
    '&', 
    'param_name=Item+permanent+shelving+location%7CLLOC&', 
    'sql_params=',
    items.permanent_location,
    '&', 
    'param_name=Item+type%7CLITYPES&', 
    'sql_params=',
    items.itype,
    '&', 
    'param_name=Item+collection+code%7CLCCODE&', 
    'sql_params=%25&', 
    'param_name=Enter+first+part+of+call+number+or+a+%25+symbol&', 
    'sql_params=%25&', 
    'param_name=Not+for+loan+status%7CLNOT_LOAN&', 
    'sql_params=%25&', 
    'param_name=Item+added+between+date1%7Cdate&', 
    'sql_params=01%2F01%2F1900&', 
    'param_name=and-date2%7Cdate&', 
    'sql_params=12%2F31%2F2099&', 
    'param_name=Item+last+borrowed+between+date1%7Cdate&', 
    'sql_params=01%2F01%2F1900&', 
    'param_name=and--date2%7Cdate&', 
    'sql_params=12%2F31%2F2099&', 
    'param_name=Item+last+seen+between+date1%7Cdate&', 
    'sql_params=01%2F01%2F1900&', 
    'param_name=and---date2%7Cdate&', 
    'sql_params=12%2F31%2F2099&', 
    'param_name=With+X+or+fewer+checkouts%7CZNUMBERS&', 
    'sql_params=999999999999&', 
    'param_name=Display+checked+out+items%7CZYES_NO&', 
    'sql_params=%25&', 
    'param_name=Display+lost%2C+missing%2C+and+withdrawn+items%7CZYES_NO&', 
    'sql_params=%25&', 
    'param_name=With+X+or+more+copies+at+this+library%7CYNUMBER&', 
    'sql_params=0&', 
    'param_name=With+X+or+more+copies+at+throughout+the+catalog%7CYNUMBER&', 
    'sql_params=0"', 
    ' target="_blank">', 
    'Shelflist for these items</a>' 
  ) AS SHELFLIST 
FROM
  items LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc') locs ON locs.authorised_value =
      Coalesce(items.permanent_location, 'PROC') LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypess ON itypess.itemtype = Coalesce(items.itype, 'XXX')
  JOIN
  branches ON items.homebranch = branches.branchcode
WHERE
  items.homebranch LIKE <<Choose your library|ZBRAN>> AND
  items.permanent_location LIKE <<Choose a permanent shelving location|LLOC>> AND
  items.itype LIKE <<Choose an item type|LITYPES>>
GROUP BY
  branches.branchname,
  locs.lib,
  itypess.description

























