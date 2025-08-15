/*
R.002784

----------

Name: GHW - Requests troubleshooting 003 - Item in-transit history
Created by: George Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-09-29 10:01:46
Modified on: 2024-01-17 11:36:25
Date last run: 2025-07-28 14:27:27

----------

Public: 0
Expiry: 0

----------

 
Identifies "In transit" history of a specific item
Shows all "In transit" data
on an item you specify
grouped by transfer ID
sorted by the date the item was shipped to its destination

Notes:

Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, etc.).
Report 3039 actively links to this report
Updated on 2022.03.29
Click here to run in a new window


----------
*/



SELECT
  UPPER(items.barcode) AS ITEM_BC,
  branchtransfers.itemnumber,
  branchtransfers.frombranch,
  branchtransfers.datesent,
  branchtransfers.tobranch,
  branchtransfers.datecancelled,
  branchtransfers.datearrived,
  branchtransfers.comments,
  branchtransfers.cancellation_reason,
  branchtransfers.reason
FROM
  items
  JOIN branchtransfers ON branchtransfers.itemnumber = items.itemnumber
WHERE
  items.barcode LIKE Concat("%", &lt;&gt;,"%")
GROUP BY
  branchtransfers.branchtransfer_id
ORDER BY
  branchtransfers.datesent DESC

























