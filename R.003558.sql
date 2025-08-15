/*
R.003558

----------

Name: GHW - Count of items by barcode number length
Created by: George Williams

----------

Group: -
     -

Created on: 2021-09-08 16:19:14
Modified on: 2024-01-17 11:28:43
Date last run: 2025-06-13 09:20:55

----------

Public: 0
Expiry: 300

----------

 
Counts all items at a library based on the length of their barcode numbers
Lists current data
At the library you specify
grouped and sorted by the name of the library and the length of the barcode numbers
links to report 3557 which lists all of the items at a library with a specified barcode number length

Notes:

Can be used to identified errors made when items are entered with an incorrect barcode number

#item barcode #length #barcode count


----------
*/



SELECT
  branches.branchname,
  Coalesce(Length(items.barcode), 0) AS ITEM_BARCODE_LENGTH,
  Count(DISTINCT items.itemnumber) AS ITEM_BARCODE_COUNT,
  CONCAT(
    'List of items'
  ) AS LINK_TO_FULL_LIST
FROM
  items JOIN
  branches ON items.homebranch = branches.branchcode
WHERE
  items.homebranch LIKE &lt;&gt;
GROUP BY
  branches.branchname,
  Length(items.barcode)

























