/*
R.003539

----------

Name: 0100 - 2024_99_e_borrower_count_category monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-08-03 09:12:55
Modified on: 2025-04-30 11:32:44
Date last run: 2026-01-01 01:00:03

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Borrower statistics - borrower counts by category&lt;/p&gt; 
&lt;ul&gt;&lt;li&gt;during the previous calendar month&lt;/li&gt; 
&lt;li&gt;at all system libraries&lt;/li&gt; 
&lt;li&gt;grouped and sorted by borrower home library and borrower category&lt;/li&gt; 
&lt;/ul&gt;&lt;br /&gt; 
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p class="updated"&gt;This report and these notes updated on 2022.03.10&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3539"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt; 
&lt;p class= "notetags" style="display: none;"&gt;#monthly #statistics #borrower #statistics #category&lt;/p&gt; 
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
&lt;/div&gt; 

----------
*/



SELECT 
  'LIBRARY' AS 'LIBRARY',  
  'BORROWER_CATEGORY' AS 'BORROWER_CATEGORY',  
  'TOTAL BORROWERS' AS 'TOTAL BORROWERS',  
  'BORROWERS RENEWED LAST MONTH' AS 'BORROWERS RENEWED LAST MONTH',  
  'BORROWERS ADDED LAST MONTH' AS 'BORROWERS ADDED LAST MONTH',  
  'BORROWERS DELETED LAST MONTH' AS 'BORROWERS DELETED LAST MONTH',  
  'THIS LIBRARY CAN ACCESS THIS CATEGORY' AS 'THIS LIBRARY CAN ACCESS THIS CATEGORY'
UNION 
(SELECT 
  branches_categories.branchname AS LIBRARY, 
  branches_categories.description AS BORROWER_CATEGORY, 
  total.Count_borrowernumber AS "TOTAL BORROWERS", 
  renewed_lm.Count_borrowernumber AS "BORROWERS RENEWED LAST MONTH", 
  added_lm.Count_borrowernumber AS "BORROWERS ADDED LAST MONTH", 
  deleted_lm.Count_borrowernumber AS "BORROWERS DELETED LAST MONTH", 
  If(limitationss.categorycode &lt;&gt; "", "Yes", "") AS "THIS LIBRARY CAN ACCESS THIS CATEGORY" 
FROM 
    (SELECT 
      branches.branchcode, 
      branches.branchname, 
      categories.categorycode, 
      categories.description 
    FROM 
      branches, 
      categories
    ) branches_categories 
  LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      borrowers.categorycode, 
      Count(borrowers.borrowernumber) AS Count_borrowernumber 
    FROM 
      borrowers 
    GROUP BY 
      borrowers.branchcode, 
      borrowers.categorycode
    ) total 
  ON total.branchcode = branches_categories.branchcode AND 
    total.categorycode = branches_categories.categorycode LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      borrowers.categorycode, 
      Count(borrowers.borrowernumber) AS Count_borrowernumber 
    FROM 
      borrowers 
    WHERE 
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode, 
      borrowers.categorycode
    ) added_lm 
  ON added_lm.branchcode = branches_categories.branchcode AND 
    added_lm.categorycode = branches_categories.categorycode LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      borrowers.categorycode, 
      Count(borrowers.borrowernumber) AS Count_borrowernumber 
    FROM 
      borrowers 
    WHERE 
      Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode, 
      borrowers.categorycode
    ) renewed_lm 
  ON renewed_lm.branchcode = branches_categories.branchcode AND 
    renewed_lm.categorycode = branches_categories.categorycode LEFT JOIN 
    (SELECT 
      deletedborrowers.branchcode, 
      deletedborrowers.categorycode, 
      Count(deletedborrowers.borrowernumber) AS Count_borrowernumber 
    FROM 
      action_logs JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'MEMBERS' AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      action_logs.action LIKE 'DELET%' 
    GROUP BY 
      deletedborrowers.branchcode, 
      deletedborrowers.categorycode
    ) deleted_lm 
  ON deleted_lm.branchcode = branches_categories.branchcode AND 
    deleted_lm.categorycode = branches_categories.categorycode LEFT JOIN 
    (SELECT 
      categories_branches.categorycode, 
      categories_branches.branchcode 
    FROM 
      categories_branches
    ) limitationss 
  ON limitationss.branchcode = branches_categories.branchcode AND 
    limitationss.categorycode = branches_categories.categorycode 
GROUP BY 
  branches_categories.branchname, 
  branches_categories.description 
ORDER BY 
  branches_categories.branchname, 
  branches_categories.description 
) 

























