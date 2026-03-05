/*
R.003421

----------

Name: 0020 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 17:45:36
Modified on: 2025-04-30 10:10:22
Date last run: 2026-01-06 15:27:48

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Monthly overview - items loaned to and borrowed from other libraries in Next Search Catalog&lt;/p&gt; 
&lt;ul&gt;&lt;li&gt;Shows item transfer counts for the previous calendar month&lt;/li&gt; 
&lt;li&gt;At all Next Search Catalog libraries&lt;/li&gt; 
&lt;li&gt;grouped and sorted by branch name&lt;/li&gt; 
&lt;/ul&gt;&lt;br /&gt; 
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p&gt;Generates data for:&lt;/p&gt; 
&lt;ul&gt; 
  &lt;li&gt;NX_ILL_LOANED_LM = count of items your library loaned to another Next Search Catalog library last month&lt;/li&gt; 
  &lt;li&gt;NX_ILL_BORROWED_LM = count of items your library borrowed from another Next Search Catalog library last month&lt;/li&gt; 
&lt;/ul&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p&gt;These counts are are based on whether you shipped or received an item via the Kansas Library Express courier.  Whether or not the item was actually checked out to a borrower is irrelevant in this count because, whether or not loaned to a borrower, the item was loaned to another library or borrowed from your library.&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p class="updated"&gt;This report and these notes updated on 2022.03.10&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3421"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt; 
&lt;p class= "notetags" style="display: none;"&gt;#monthly #statistics #overview #monthly_overview&lt;/p&gt; 
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
&lt;/div&gt; 

----------
*/



SELECT 
  'BRANCHNAME' AS BRANCHNAME,
  'NX_ILL_LOANED_LM' AS NX_ILL_LOANED_LM,
  'NX_ILL_BORROWED_LM' AS NX_ILL_BORROWED_LM
UNION  
(SELECT 
  'BRANCHNAME' AS BRANCHNAME,
  'NX_ILL_LOANED_LM' AS NX_ILL_LOANED_LM, 
  'NX_ILL_BORROWED_LM' AS NX_ILL_BORROWED_LM
UNION
(SELECT 
  branches.branchname, 
  Coalesce(ILL_LOANED.count, 0) AS NX_ILL_LOANED_LM, 
  Coalesce(ILL_BORROWED.count, 0) AS NX_ILL_BORROWED_LM 
FROM 
  branches LEFT JOIN 
    (SELECT 
      items.homebranch, 
      COUNT(&ast;) AS count 
    FROM 
      branchtransfers LEFT JOIN 
      items ON branchtransfers.itemnumber = items.itemnumber 
    WHERE 
      items.homebranch &lt;&gt; branchtransfers.tobranch AND 
      Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND 
      branchtransfers.tobranch &lt;&gt; branchtransfers.frombranch AND 
      branchtransfers.comments IS NULL  AND
      branchtransfers.reason = 'reserve'
    GROUP BY 
      items.homebranch 
    ) ILL_LOANED 
  ON branches.branchcode = ILL_LOANED.homebranch LEFT JOIN 
    (SELECT 
      branchtransfers.tobranch, 
      COUNT(&ast;) AS count 
    FROM 
      branchtransfers LEFT JOIN 
      items ON branchtransfers.itemnumber = items.itemnumber 
    WHERE 
      branchtransfers.tobranch &lt;&gt; items.homebranch AND 
      Month(branchtransfers.datearrived) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(branchtransfers.datearrived) = Year(Now() - INTERVAL 1 MONTH) AND 
      branchtransfers.frombranch &lt;&gt; branchtransfers.tobranch AND 
      branchtransfers.comments IS NULL  AND
      branchtransfers.reason = 'reserve'
    GROUP BY 
      branchtransfers.tobranch 
    ) ILL_BORROWED 
  ON branches.branchcode = ILL_BORROWED.tobranch 
GROUP BY 
  branches.branchname
ORDER BY 
  branches.branchname))

























