/*
R.003889

----------

Name: Sandbox
Created by: George Williams

----------

Group: -
     -

Created on: 2025-06-09 15:43:33
Modified on: 2025-06-09 15:43:57
Date last run: 2025-06-09 15:43:57

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  '-' AS CATEGORY,
  'Count of items by PERMANENT LOCATION system-wide' AS DESCRIPTION,
  '-' AS CODE,
  NULL AS COUNT
UNION
SELECT
  '- Shelving location' AS CATEGORY,
  authorised_values.lib AS DESCRIPTION,
  authorised_values.authorised_value AS CODE,
  Count(items.itemnumber) AS COUNT
FROM
  authorised_values LEFT JOIN
  items ON items.permanent_location = authorised_values.authorised_value
WHERE
  authorised_values.category = 'LOC'
GROUP BY
  authorised_values.authorised_value
UNION
SELECT
  '--' AS CATEGORY,
  'Count of items by ITEMTYPE system-wide' AS DESCRIPTION,
  '--' AS CODE,
  NULL AS COUNT
UNION
SELECT
  '-- item_type' AS CATEGORY,
  itemtypes.description AS DESCRIPTION,
  itemtypes.itemtype AS CODE,
  Count(items.itemnumber) AS COUNT
FROM
  itemtypes LEFT JOIN
  items ON items.itype = itemtypes.itemtype
GROUP BY
  itemtypes.itemtype
UNION
SELECT
  '---' AS CATEGORY,
  'Count of items by CCODE system-wide' AS DESCRIPTION,
  '---' AS CODE,
  NULL AS COUNT
UNION
SELECT
  '--- Collection code' AS CATEGORY,
  authorised_values.lib AS DESCRIPTION,
  authorised_values.authorised_value AS CODE,
  Count(items.itemnumber) AS COUNT
FROM
  authorised_values LEFT JOIN
  items ON items.ccode = authorised_values.authorised_value
WHERE
  authorised_values.category = 'CCODE'
GROUP BY
  authorised_values.authorised_value
ORDER BY
  CATEGORY,
  DESCRIPTION,
  CODE
LIMIT 1000

























