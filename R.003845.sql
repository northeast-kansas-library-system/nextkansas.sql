/*
R.003845

----------

Name: GHW - Item types and CCODES counts
Created by: George Williams

----------

Group: -
     -

Created on: 2024-06-07 11:18:57
Modified on: 2024-06-07 11:18:57
Date last run: 2024-07-29 15:35:55

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  types_codes.description, 
  types_codes.lib, 
  Count(DISTINCT items.itemnumber) AS Count_itemnumber, 
  Concat_Ws( 
    '', 
    '<a class="btn btn-default btn-xs noprint" ', 
    'href="http:', 
    '/cgi-bin/koha/reports/guided_reports.pl?reports=2731&phase=Run+this+report', 
    '&param_name=Item+home+library%7CZBRAN&sql_params=', 
    '%25', 
    '&param_name=Item+permanent+shelving+location%7CLLOC&sql_params=', 
    '%25', 
    '&param_name=Item+type%7CLITYPES&sql_params=', 
    types_codes.itemtype, 
    '&param_name=Item+collection+code%7CLCCODE&sql_params=', 
    types_codes.authorised_value, 
    '&param_name=Enter+first+part+of+call+number+or+a+%25+symbol&sql_params=', 
    '%25', 
    '&param_name=Not+for+loan+status%7CLNOT_LOAN&sql_params=', 
    '%25', 
    '&param_name=Item+added+between+date1%7Cdate&sql_params=', 
    '1900-01-01', 
    '&param_name=and-date2%7Cdate&sql_params=', 
    '3000-12-31', 
    '&param_name=Item+last+borrowed+between+date1%7Cdate&sql_params=', 
    '1900-01-01', 
    '&param_name=and--date2%7Cdate&sql_params=', 
    '3000-12-31', 
    '&param_name=Item+last+seen+between+date1%7Cdate&sql_params=', 
    '1900-01-01', 
    '&param_name=and---date2%7Cdate&sql_params=', 
    '3000-12-31', 
    '&param_name=With+X+or+fewer+checkouts%7CZNUMBERS&sql_params=', 
    '999999999999', 
    '&param_name=Display+checked+out+items%7CZYES_NO&sql_params=', 
    '%25', 
    '&param_name=Display+lost%2C+missing%2C+and+withdrawn+items%7CZYES_NO&sql_params=', 
    '%25', 
    '&param_name=With+X+or+more+copies+at+this+library%7CYNUMBER&sql_params=', 
    '0', 
    '&param_name=With+X+or+more+copies+at+throughout+the+catalog%7CYNUMBER&sql_params=', 
    '0', 
    '" target="_blank"', 
    '>2731</a>' 
  ) AS LINK 
FROM ( 
    SELECT itemtypes.itemtype, 
      itemtypes.description, 
      authorised_values.lib, 
      authorised_values.category, 
      authorised_values.authorised_value 
    FROM itemtypes, 
      authorised_values 
    WHERE authorised_values.category = 'CCODE' 
  ) types_codes 
  JOIN items 
    ON items.itype = types_codes.itemtype 
    AND items.ccode = types_codes.authorised_value 
GROUP BY 
  types_codes.description, 
  types_codes.lib 
ORDER BY 
  types_codes.description, 
  types_codes.lib 

























