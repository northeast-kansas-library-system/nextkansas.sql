/*
R.003041

----------

Name: GHW - Flexible requests history spreadsheet
Created by: George Williams

----------

Group: Administrative Reports
     Testing

Created on: 2018-01-17 14:45:13
Modified on: 2024-01-17 11:58:26
Date last run: 2025-10-27 09:57:27

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a spreadsheet style report of current and past request information based on very flexible parameters&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows the history of any active, filled, and cancelled requests in NExpress&lt;/li&gt;
&lt;li&gt;at all pickup libraries or at the pickup library you specify&lt;/li&gt;
&lt;li&gt;with the request status and progress that you specify&lt;/li&gt;
&lt;li&gt;with the hold suspension status you specify&lt;/li&gt;
&lt;li&gt;and with the library card, biblionumber, or item barcode number you specify&lt;/li&gt;
&lt;li&gt;grouped by reserve ID number&lt;/li&gt;
&lt;li&gt;sorted by the last time the request was updated&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3041&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  requests.reserve_id,
  requests.statuss AS STATUS,
  If(requests.cancellationdate IS NOT NULL, "Cancelled", If(requests.found = "T", "In transit", If(requests.found = "F", "Filled / finished", If(requests.found = "W", "Waiting for pickup", "Still active")))) AS PROGRESS,
  borrowers.cardnumber AS CARDNUMBER,
  requests.branchcode AS PICKUP_BRANCH,
  requests.reservedate,
  requests.expirationdate,
  requests.cancellationdate,
  requests.timestamp,
  requests.suspend,
  requests.suspend_until,
  requests.biblionumber,
  Coalesce(items.barcode, deleteditems.barcode) AS ITEM_BC,
  Coalesce(items.homebranch, deleteditems.homebranch) AS ITEM_HOME,
  Coalesce(items.location, deleteditems.location) AS LOCATION,
  Coalesce(items.itype, deleteditems.itype) AS ITYPE,
  Coalesce(items.ccode, deleteditems.ccode) AS CCODE,
  Coalesce(items.itemcallnumber, deleteditems.itemcallnumber) AS CALL_NO,
  Coalesce(biblio.author, deletedbiblio.author) AS AUTHOR,
  Coalesce(biblio.title, deletedbiblio.title) AS TITLE
FROM
  borrowers
  JOIN (SELECT
        reserves.reserve_id,
        reserves.borrowernumber,
        reserves.reservedate,
        reserves.biblionumber,
        reserves.branchcode,
        reserves.notificationdate,
        reserves.reminderdate,
        reserves.cancellationdate,
        reserves.reservenotes,
        reserves.priority,
        reserves.found,
        reserves.timestamp,
        reserves.itemnumber,
        reserves.waitingdate,
        reserves.expirationdate,
        reserves.lowestPriority,
        reserves.suspend,
        reserves.suspend_until,
        reserves.itemtype,
        If(reserves.reserve_id IS NOT NULL, "Active", "-") AS statuss
      FROM
        reserves
      UNION
      SELECT
        old_reserves.reserve_id,
        old_reserves.borrowernumber,
        old_reserves.reservedate,
        old_reserves.biblionumber,
        old_reserves.branchcode,
        old_reserves.notificationdate,
        old_reserves.reminderdate,
        old_reserves.cancellationdate,
        old_reserves.reservenotes,
        old_reserves.priority,
        old_reserves.found,
        old_reserves.timestamp,
        old_reserves.itemnumber,
        old_reserves.waitingdate,
        old_reserves.expirationdate,
        old_reserves.lowestPriority,
        old_reserves.suspend,
        old_reserves.suspend_until,
        old_reserves.itemtype,
        If(old_reserves.cancellationdate IS NOT NULL, "Cancelled", "Filled") AS statuss
      FROM
        old_reserves) requests ON borrowers.borrowernumber = requests.borrowernumber
  LEFT JOIN items ON requests.itemnumber = items.itemnumber
  LEFT JOIN deleteditems ON requests.itemnumber = deleteditems.itemnumber
  LEFT JOIN biblio ON requests.biblionumber = biblio.biblionumber
  LEFT JOIN deletedbiblio ON requests.biblionumber = deletedbiblio.biblionumber
WHERE
  requests.branchcode LIKE &lt;&gt; AND
  requests.statuss LIKE &lt;&gt; AND
  If(requests.cancellationdate IS NOT NULL, "Cancelled", If(requests.found = "T", "In transit", If(requests.found = "F", "Filled", If(requests.found = "W", "Waiting for pickup", "Still active")))) LIKE &lt;&gt; AND
  If(requests.suspend &lt;&gt; 0, "Suspended", "-") LIKE &lt;&gt; AND
  borrowers.cardnumber LIKE Concat("%", &lt;&gt;, "%") AND
  requests.biblionumber LIKE Concat("%", &lt;&gt;, "%") AND
  Coalesce(Coalesce(items.barcode, "-"), Coalesce(deleteditems.barcode, "-")) LIKE Concat("%", &lt;&gt;, "%")
GROUP BY
  requests.reserve_id
ORDER BY
  requests.timestamp DESC

























