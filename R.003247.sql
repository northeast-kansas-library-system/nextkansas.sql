/*
R.003247

----------

Name: GHW - value of items checked out in the previous calendar month
Created by: George Williams

----------

Group: -
     -

Created on: 2019-08-08 15:26:19
Modified on: 2024-01-17 11:22:18
Date last run: 2024-05-14 11:36:37

----------

Public: 0
Expiry: 300

----------

 
Generates total value of all items checked out during the  previous calendar month at the library you specify
Shows value of items checkered out during the previous calendar month
at the library you specify (no matter which library owned the item)
grouped by replacement price, check-out branch, item type, item number, date and time of checkout, library name, and item type description.
sorted by checkout library and item type description
links

Notes:


Summarizes the replacement cost of every item checked out, every time it was checked out at the specified library during the previous calendar month.  If, for example, a $10.00 MOVIE checks out 5 times at one library last month, those checkouts will contribute $50.00 to the total in the column for "MOVIE" at that library for last month.
This report relies on the accuracy of the data in the 952$v field.  If, for example, the 952$v field has accidentally been sent to $999,999.99 for an item, each time that item checks out in a month, the total value for the VALUE_OF_ALL_ITEMS_CHECKED_OUT column will increase by slightly less than one million dollars.  Similarly, if the 952$v is left blank, no value will be recorded.
This report only looks at check-outs - it does not record data for renewals.


Click here to run in a new window


----------
*/



SELECT
  branchsitypes.branchname AS CHECK_OUT_LIBRARY,
  branchsitypes.description AS ITEM_TYPE,
  Sum(statsitmes.replacementprice) AS VALUE_OF_ALL_ITEMS_CHECKED_OUT
FROM
  (
    SELECT
      branches.branchcode,
      branches.branchname,
      itemtypes.itemtype,
      itemtypes.description
    FROM
      branches,
      itemtypes
  ) branchsitypes
  LEFT JOIN (
    SELECT
      items.replacementprice,
      statistics.branch,
      statistics.itemtype,
      Coalesce(items.itemnumber, deleteditems.itemnumber) AS itemnumber,
      statistics.datetime
    FROM
      statistics
      LEFT JOIN items
        ON items.itemnumber = statistics.itemnumber
      LEFT JOIN deleteditems
        ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      Month(statistics.datetime) = Month(Curdate() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Curdate() - INTERVAL 1 MONTH) AND
      statistics.type = 'issue'
    GROUP BY
      items.replacementprice,
      statistics.branch,
      statistics.itemtype,
      statistics.datetime
  ) statsitmes
    ON statsitmes.branch = branchsitypes.branchcode AND
      statsitmes.itemtype = branchsitypes.itemtype
WHERE
  branchsitypes.branchcode LIKE &lt;&gt;
GROUP BY
  branchsitypes.branchname,
  branchsitypes.description

























