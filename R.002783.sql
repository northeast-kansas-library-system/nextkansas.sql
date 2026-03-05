/*
R.002783

----------

Name: GHW - Requests troubleshooting 002 - Item request history
Created by: George Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-09-29 09:54:40
Modified on: 2024-01-17 11:36:27
Date last run: 2025-05-28 09:41:53

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Identifies old requests on a specific item&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows all finished requests&lt;/li&gt;
&lt;li&gt;on an item you specify&lt;/li&gt;
&lt;li&gt;sorted by the last activity on the item request&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, etc.).&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2783&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  old_reserves.timestamp,
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  borrowers.cardnumber AS BORROWER,
  old_reserves.branchcode AS PICKUP_LOCATION,
  old_reserves.reservedate,
  old_reserves.waitingdate,
  old_reserves.cancellationdate,
  old_reserves.reservenotes,
  old_reserves.found
FROM
  items JOIN
  old_reserves
    ON old_reserves.itemnumber = items.itemnumber JOIN
  borrowers
    ON old_reserves.borrowernumber = borrowers.borrowernumber JOIN
  biblio
    ON old_reserves.biblionumber = biblio.biblionumber
WHERE
  items.barcode = &lt;&gt;
ORDER BY
  old_reserves.timestamp DESC

























