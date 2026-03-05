/*
R.002026

----------

Name: Items Marked Lost
Created by: Heather Braum

----------

Group: Monthly cleanup
     -

Created on: 2013-09-03 10:38:20
Modified on: 2025-07-03 11:31:41
Date last run: 2025-12-16 12:58:18

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Items marked lost. Enhanced -- choose branch, run.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items that are currently marked as "(Lost)"&lt;/li&gt;
&lt;li&gt;at the library you select&lt;/li&gt;
&lt;li&gt;sorted by item call number&lt;/li&gt;
&lt;li&gt;contains links to the edit item page of each item&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Monthly cleanup&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;There are 6 "Lost" statuses in NExpress - (Lost) [status = 1]; Lost (more than 45 days overdue) [status = 2]; Missing (unable to location on shelf) [status = 3]; Lost (Damaged/Replace) [status = 4]; Lost (Patron Claims Returned) [status = 5]; Lost (more than 45 days overdue) [status = 7].  This report only shows items that have a status of "(Lost)" so nothing that was automatically marked as "Lost (more than 45 days overdue)" appears on this report.&lt;br /&gt;&lt;/p&gt;
&lt;p&gt;The only items that will appear are items that have manually been marked with the "(Lost)" status [status = 1].&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Report created by HB.  Explanatory notes added by GHW on 2018.06.01.&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2026&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  items.datelastseen,
  biblio.title,
  biblio.author,
  biblioitems.publicationyear,
  items.location,
  items.ccode,
  items.itype,
  items.itemcallnumber,
  items.barcode,
  items.holdingbranch,
  Concat('edit item') AS "edit item"
FROM
  items
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN biblioitems ON biblio.biblionumber = biblioitems.biblionumber
WHERE
  items.homebranch LIKE &lt;&gt; AND
  items.itemlost LIKE &lt;&gt;
ORDER BY
  items.itemcallnumber

























