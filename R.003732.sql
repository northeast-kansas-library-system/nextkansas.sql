/*
R.003732

----------

Name: GHW - Home library and item counts by first six digits of item barcode number
Created by: George Williams

----------

Group: -
     -

Created on: 2023-06-09 11:53:35
Modified on: 2024-01-17 11:14:24
Date last run: 2023-06-09 11:55:29

----------

Public: 0
Expiry: 300

----------

 
  Counts items by the first six digits of item barcode number.
  
    counts items currently in the catalog
    at all libraries
    grouped by first six digits of item barcode number and library
    sorted by first six digits of item barcode number
  
  
  Click here to download as a csv file
  #barcode #items #prefix
  


----------
*/



SELECT
  Left(items.barcode, 6) AS FIRST_6_DIGITS_OF_ITEM_BARCODE,
  branches.branchname AS LIBRARY_NAME,
  Count(items.itemnumber) AS ITEM_COUNT
FROM
  branches JOIN
  items ON items.homebranch = branches.branchcode
GROUP BY
  Left(items.barcode, 6),
  branches.branchname
ORDER BY
  barcode

























