/*
R.002801

----------

Name: GHW - Requests troubleshooting 005 - Patron requests history
Created by: George Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-10-11 09:41:49
Modified on: 2024-01-21 10:39:28
Date last run: 2024-01-21 10:42:49

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Identifies past requests made by a specific patron&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows request history&lt;/li&gt;
&lt;li&gt;on a patron you specify&lt;/li&gt;
&lt;li&gt;sorted by the last activity on the request&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report will not include data for titles that have been deleted from the catalog.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, patron received e-mail but we can't find the request, etc.).&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat_Ws('', 
    'View title' 
  ) AS VIEW_TITLE,
  old_reserves.timestamp,
  biblio.author,
  biblio.title,
  borrowers.cardnumber AS LIBRARY_CARD,
  old_reserves.branchcode,
  old_reserves.reservedate,
  old_reserves.waitingdate,
  old_reserves.cancellationdate,
  old_reserves.reservenotes,
  old_reserves.found
FROM
  old_reserves JOIN
  borrowers
    ON old_reserves.borrowernumber = borrowers.borrowernumber JOIN
  biblio
    ON old_reserves.biblionumber = biblio.biblionumber
WHERE
  borrowers.cardnumber LIKE Concat("%", &lt;&gt;)
ORDER BY
  old_reserves.timestamp
DESC

























