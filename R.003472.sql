/*
R.003472

----------

Name: GHW - Replacement cost of library materials by Item Type
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-03 15:41:42
Modified on: 2024-01-17 12:01:18
Date last run: 2024-10-08 10:24:15

----------

Public: 0
Expiry: 300

----------

 
Shows replacement cost of collection
Results are based on materials currently in the catalog
at the library, shelving location, and item type you specify
grouped and sorted by library, shelving location, and item type

Notes:

This report will only return values based on the "Cost, replacement price" field in the item record (Marc subfield 952$v).  If no value is entered in this field, the value for that item will be $0.00.  If that field has been incorrectly entered, that incorrect value will be a part of the total.
Report 3362 can show you items at your library with a blank or 0 value "Cost, replacement price" field: click here to run report 3362

Click here to run in a new window
tag goes here


----------
*/



SELECT
  branches.branchname AS LIBRARY,
  locs.lib AS SHELVING_LOCATION,
  itypess.description AS ITEM_TYPE,
  Count(items.itemnumber) AS ITEM_COUNT,
  Coalesce(Sum(items.replacementprice), 0) AS REPLACEMENT_COST,
  Concat( 
    '', 
    'Shelflist for these items' 
  ) AS SHELFLIST 
FROM
  items LEFT JOIN
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
    ON locs.authorised_value = Coalesce(items.permanent_location, 'PROC') 
  LEFT JOIN
  (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
  ) itypess 
    ON itypess.itemtype = Coalesce(items.itype, 'XXX') 
  JOIN 
    branches ON items.homebranch = branches.branchcode
WHERE
  items.homebranch LIKE &lt;&gt; AND
  items.permanent_location LIKE &lt;&gt; AND
  items.itype LIKE &lt;&gt;
GROUP BY
  branches.branchname,
  locs.lib,
  itypess.description

























