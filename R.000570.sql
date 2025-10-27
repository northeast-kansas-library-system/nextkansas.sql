/*
R.000570

----------

Name: Monthly 005 New materials added by permanent loction, item type, and collection code
Created by:  Tongie Book Club

----------

Group: -
     -

Created on: 2009-06-01 16:56:47
Modified on: 2025-03-26 01:12:08
Date last run: 2025-10-01 09:06:48

----------

Public: 0
Expiry: 0

----------

Shows count of new items added to a collection in last month by item type and shelving location.

Major update on February 2, 2022 - adds link to Report 2731 among other things - The link to 2731 will show you everything added to the specified collection between the first of the month you run the report for and the present -- i.e. it won't be limited to the same month that you run this report for.

Updated in March of 2025 to link to 3879 instead of 2731.

----------
*/



SELECT
  descriptions.branchname,
  descriptions.permanent_location AS PERM_LOCATION,
  descriptions.description AS ITEM_TYPE,
  descriptions.ccode AS COLLECTION_CODE,
  new.Count_itemnumber,
  Concat( 
    '&gt;,

    '-',

    &lt;&gt;,

    '-01',

    '&param_name=and-date2%7Cdate&sql_params=',

      STR_TO_DATE(
      Concat(&lt;&gt;,

      '-',

      &lt;&gt;,

      '-01') , '%Y-%m-%d') + interval 1 month,

    '&param_name=Item+last+borrowed+between+date1%7Cdate&sql_params=',

    '2000-01-01',

    '&param_name=and--date2%7Cdate&sql_params=',

    '2199-12-31',

    '&param_name=Item+last+seen+between+date1%7Cdate&sql_params=',

    '2000-01-01',

    '&param_name=and---date2%7Cdate&sql_params=',

    '2199-12-31',

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

    '0&op=run"',

    ' target="_blank"&gt;Go to shelf list' 
  ) AS LINK_TO_SHELFLIST
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
      Year(items.dateaccessioned) = &lt;&gt; AND
      Month(items.dateaccessioned) = &lt;&gt;
    GROUP BY
      items.homebranch,
      items.permanent_location,
      items.itype,
      items.ccode) new ON new.homebranch = descriptions.branchcode AND
      new.itype = descriptions.itemtype AND
      new.permanent_location = descriptions.permanent_location_code AND
      new.ccode = descriptions.ccode_code
WHERE
  descriptions.branchcode LIKE &lt;&gt;
ORDER BY
  descriptions.branchname,
  PERM_LOCATION,
  ITEM_TYPE,
  COLLECTION_CODE

























