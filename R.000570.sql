/*
R.000570

----------

Name: Monthly 005 New materials added by permanent loction, item type, and collection code
Created by:  Tongie Book Club

----------

Group: -
     -

Created on: 2009-06-01 16:56:47
Modified on: 2022-02-02 18:05:22
Date last run: 2022-10-03 12:51:17

----------

Public: 0
Expiry: 0

----------

Shows count of new items added to a collection in last month by item type and shelving location.

Major update on February 2, 2022 - adds link to Report 2731 among other things - The link to 2731 will show you everything added to the specified collection between the first of the month you run the report for and the present -- i.e. it won't be limited to the same month that you run this report for.

----------
*/



SELECT
  descriptions.branchname,
  descriptions.permanent_location AS PERM_LOCATION,
  descriptions.description AS ITEM_TYPE,
  descriptions.ccode AS COLLECTION_CODE,
  new.Count_itemnumber,
  Concat(
    '<a class="btn btn-default" href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=2731&phase=Run+this+report&param_name=Item+home+library%7CZBRAN&sql_params=', 
    <<Choose your library|branches>>, 
    '&param_name=Item+permanent+shelving+location%7CLLOC&sql_params=%25',
    '&param_name=Item+type%7CLITYPES&sql_params=',
    descriptions.itemtype,
    '&param_name=Item+collection+code%7CLCCODE&sql_params=',
    descriptions.ccode_code,
    '&param_name=Enter+first+part+of+call+number+or+a+%25+symbol&sql_params=%25', 
    '&param_name=Not+for+loan+status%7CLNOT_LOAN&sql_params=%25&param_name=Item+added+between+date1%7Cdate&sql_params=',
    <<Choose month|MONTH>>,
    '%2F01%2F',
    <<Choose year|YEAR>>,
    '&param_name=and+date2%7Cdate&sql_params=12%2F31%2F2050',
    '&param_name=Item+last+borrowed+between+date1%7Cdate&sql_params=01%2F01%2F2000&param_name=and++date2%7Cdate&sql_params=12%2F31%2F2050',
    '&param_name=Item+last+seen+between+date1%7Cdate&sql_params=01%2F01%2F2000&param_name=and+++date2%7Cdate&sql_params=12%2F31%2F2050',
    '&param_name=With+X+or+fewer+checkouts%7CZNUMBERS&sql_params=999999999999',
    '&param_name=Display+checked+out+items%7CZYES_NO&sql_params=%25',
    '&param_name=Display+lost%2C+missing%2C+and+withdrawn+items%7CZYES_NO&sql_params=%25',
    '&param_name=With+X+or+more+copies+at+this+library%7CYNUMBER&sql_params=0',
    '&param_name=With+X+or+more+copies+at+throughout+the+catalog%7CYNUMBER&sql_params=0" ',
    'target="_blank">Go to title</a>'
  ) AS LINK_TO_2731
FROM
  (SELECT
      branches.branchname,
      branches.branchcode,
      permanent_location.authorised_value AS permanent_location_code,
      permanent_location.lib AS permanent_location,
      itemtypes.itemtype,
      itemtypes.description,
      ccodes.authorised_value AS ccode_code,
      ccodes.lib AS ccode
    FROM
      branches,
      (SELECT
          authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib,
          authorised_values.lib_opac
        FROM
          authorised_values
        WHERE
          authorised_values.category = 'loc') permanent_location,
      itemtypes,
      (SELECT
          authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib,
          authorised_values.lib_opac
        FROM
          authorised_values
        WHERE
          authorised_values.category = 'ccode') ccodes) descriptions INNER JOIN
  (SELECT
      items.homebranch,
      items.permanent_location,
      items.itype,
      items.ccode,
      Count(DISTINCT items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      Year(items.dateaccessioned) = <<Choose year|YEAR>> AND
      Month(items.dateaccessioned) = <<Choose month|MONTH>>
    GROUP BY
      items.homebranch,
      items.permanent_location,
      items.itype,
      items.ccode) new ON new.homebranch = descriptions.branchcode AND
      new.itype = descriptions.itemtype AND
      new.permanent_location = descriptions.permanent_location_code AND
      new.ccode = descriptions.ccode_code
WHERE
  descriptions.branchcode LIKE <<Choose your library|branches>>
ORDER BY
  descriptions.branchname,
  PERM_LOCATION,
  ITEM_TYPE,
  COLLECTION_CODE

























