/*
R.002785

----------

Name: GHW - Requests troubleshooting 004 - Item check-out history
Created by: George Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-09-29 10:35:34
Modified on: 2024-02-07 16:15:59
Date last run: 2025-12-30 11:25:32

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Identifies circulation history on a specific item&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows all circulation history that has been completed&lt;/li&gt;
&lt;li&gt;on an item you specify&lt;/li&gt;
&lt;li&gt;sorted by the last date the item was returned&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, etc.).&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2785&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  old_issues.returndate,
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  borrowers.cardnumber AS BORROWER,
  old_issues.branchcode AS CHECK_OUT_BRANCH,
  old_issues.issuedate,
  old_issues.date_due,
  old_issues.lastreneweddate
FROM
  old_issues JOIN
  items
    ON old_issues.itemnumber = items.itemnumber JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  borrowers
    ON old_issues.borrowernumber = borrowers.borrowernumber
WHERE
  items.barcode = &lt;&gt;
ORDER BY
  old_issues.returndate DESC

























