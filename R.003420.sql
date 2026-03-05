/*
R.003420

----------

Name: 0015 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 17:10:37
Modified on: 2025-04-30 10:08:11
Date last run: 2026-01-06 15:27:36

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Monthly overview - borrower statistics&lt;/p&gt; 
&lt;ul&gt;&lt;li&gt;Shows borrower counts for the previous calendar month&lt;/li&gt; 
&lt;li&gt;At all Next Search Catalog libraries&lt;/li&gt; 
&lt;li&gt;grouped and sorted by branch name&lt;/li&gt; 
&lt;/ul&gt;&lt;br /&gt; 
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p&gt;Generates data for:&lt;/p&gt; 
&lt;ul&gt; 
  &lt;li&gt;BORROWER_ACCT_USED_LM = number of borrower accounts used to check out materials last month&lt;/li&gt; 
  &lt;li&gt;TOTAL_BORROWERS = number of total borrowers with this home library&lt;/li&gt; 
  &lt;li&gt;B_ADDED_LM = number of borrowers with this home library added last month&lt;/li&gt; 
  &lt;li&gt;B_RENEWED_LM = number of borrowers with this home library renewed last month&lt;/li&gt; 
  &lt;li&gt;B_DELETED_LM = number of borrowers with this home library deleted last month&lt;/li&gt; 
&lt;/ul&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p&gt;These counts are current at the time the report is run (which for Next Search Catalog is usually between 12:01 a.m. and 4:00 a.m. on the first day of the month).&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p class="updated"&gt;This report and these notes updated on 2022.03.10&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3420"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt; 
&lt;p class= "notetags" style="display: none;"&gt;#monthly #statistics #overview #monthly_overview&lt;/p&gt; 
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
&lt;/div&gt; 

----------
*/



SELECT 
  'branchname' AS branchname,
  'BORROWER_ACCT_USED_LM' AS BORROWER_ACCT_USED_LM,
  'TOTAL_BORROWERS' AS TOTAL_BORROWERS,
  'B_ADDED_LM' AS B_ADDED_LM,
  'B_RENEWED_LM' AS B_RENEWED_LM,
  'B_DELETED_LM' AS B_DELETED_LM
UNION 
(SELECT 
  branches.branchname, 
  Coalesce(ACCT_USED.count, 0) AS BORROWER_ACCT_USED_LM, 
  Coalesce(BORROWERS1.COUNT, 0) AS TOTAL_BORROWERS, 
  Coalesce(BORROWERSA.COUNT, 0) AS B_ADDED_LM, 
  Coalesce(BORROWERSR.COUNT, 0) AS B_RENEWED_LM, 
  Coalesce(BORROWESD.COUNT, 0) AS B_DELETED_LM 
FROM 
  branches LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Count(&ast;) AS COUNT 
    FROM 
      borrowers 
    WHERE 
      borrowers.dateenrolled &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY 
      borrowers.branchcode 
    ) BORROWERS1 
  ON branches.branchcode = BORROWERS1.branchcode LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Count(&ast;) AS COUNT 
    FROM 
      borrowers 
    WHERE 
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode 
    ) BORROWERSA 
  ON branches.branchcode = BORROWERSA.branchcode LEFT JOIN 
    (SELECT 
      deletedborrowers.branchcode, 
      Count(&ast;) AS COUNT 
    FROM 
      action_logs JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'MEMBERS' AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      action_logs.action LIKE 'DELET%' 
    GROUP BY 
      deletedborrowers.branchcode 
    ) BORROWESD 
  ON branches.branchcode = BORROWESD.branchcode LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Count(&ast;) AS COUNT 
    FROM 
      borrowers 
    WHERE 
      Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode 
    ) BORROWERSR 
  ON branches.branchcode = BORROWERSR.branchcode LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS count 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew' OR 
        statistics.type = 'localuse') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) ACCT_USED 
  ON ACCT_USED.branch = branches.branchcode 
GROUP BY 
  branches.branchname 
ORDER BY 
  branches.branchname)

























