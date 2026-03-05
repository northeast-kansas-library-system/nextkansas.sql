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
Date last run: 2025-11-24 14:46:02

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Identifies "In transit" history of a specific item&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows all "In transit" data&lt;/li&gt;
&lt;li&gt;on an item you specify&lt;/li&gt;
&lt;li&gt;grouped by transfer ID&lt;/li&gt;
&lt;li&gt;sorted by the date the item was shipped to its destination&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, etc.).&lt;/p&gt;
&lt;p&gt;Report 3039 actively links to this report&lt;/p&gt;
&lt;p&gt;Updated on 2022.03.29&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2784&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

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

























