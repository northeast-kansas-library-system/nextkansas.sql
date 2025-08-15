/*
R.003209

----------

Name: GHW - Rotating collections - Report 1
Created by: George Williams

----------

Group: -
     -

Created on: 2019-06-10 11:43:41
Modified on: 2024-01-17 11:54:07
Date last run: 2019-06-10 15:06:34

----------

Public: 0
Expiry: 300

----------

 
Identifies all "Rotating collection" groups
Shows all current groups
grouped and sorted by collection ID
links to the print and edit reports for "Rotating collections"

Notes:

Click here to run in a new window


----------
*/



SELECT
  Concat_WS(
    "",
    Concat("Title: ", collections.colTitle),
    Concat("Description: ", collections.colDesc)
  ) AS COLLECTION,
  Concat('Run report to print') AS PRINT,
  Concat('Run report to batch edit') AS EDIT
FROM
  collections
GROUP BY
  collections.colId
ORDER BY
  collections.colId
DESC
  

























