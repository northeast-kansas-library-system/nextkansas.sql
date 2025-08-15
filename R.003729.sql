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
    '', 
    'Shelflist for these items' 
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
  items.homebranch LIKE &lt;&gt; AND
  items.permanent_location LIKE &lt;&gt; AND
  items.itype LIKE &lt;&gt;
GROUP BY
  branches.branchname,
  locs.lib,
  itypess.description

























