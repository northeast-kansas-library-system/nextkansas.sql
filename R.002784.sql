/*
R.002784

----------

Name: GHW - Requests troubleshooting 003 - Item in-transit history
Created by: George H Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-09-29 10:01:46
Modified on: 2022-03-29 13:37:48
Date last run: 2023-04-06 14:54:11

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Identifies "In transit" history of a specific item</p>
<ul><li>Shows all "In transit" data</li>
<li>on an item you specify</li>
<li>grouped by transfer ID</li>
<li>sorted by the date the item was shipped to its destination</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, etc.).</p>
<p>Report 3039 actively links to this report</p>
<p>Updated on 2022.03.29</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2784&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
  items.barcode LIKE Concat("%", <<Enter item barcode number>>,"%")
GROUP BY
  branchtransfers.branchtransfer_id
ORDER BY
  branchtransfers.datesent DESC

























