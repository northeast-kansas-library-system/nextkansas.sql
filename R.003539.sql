/*
R.003539

----------

Name: E1 Borrower statistics - borrower count by borrower category
Created by: George H Williams

----------

Group: Statistics
     2023 beginning of month statistics

Created on: 2021-08-03 09:12:55
Modified on: 2023-02-10 14:21:52
Date last run: 2023-03-01 01:00:03

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Borrower statistics - borrower counts by category</p> 
<ul><li>during the previous calendar month</li> 
<li>at all system libraries</li> 
<li>grouped and sorted by borrower home library and borrower category</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3539">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #borrower #statistics #category</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  branches_categories.branchname AS LIBRARY, 
  branches_categories.description AS BORROWER_CATEGORY, 
  total.Count_borrowernumber AS "TOTAL BORROWERS", 
  renewed_lm.Count_borrowernumber AS "BORROWERS RENEWED LAST MONTH", 
  added_lm.Count_borrowernumber AS "BORROWERS ADDED LAST MONTH", 
  deleted_lm.Count_borrowernumber AS "BORROWERS DELETED LAST MONTH", 
  If(limitationss.categorycode <> "", "Yes", "") AS "THIS LIBRARY CAN ACCESS THIS CATEGORY" 
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
  

























