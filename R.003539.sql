/*
R.003539

----------

Name: 0050 - 2024_99_e_borrower_count_category monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-08-03 09:12:55
Modified on: 2026-01-30 17:30:13
Date last run: 2026-03-01 00:50:01

----------

Public: 0
Expiry: 300

----------

<div> 
<p>Borrower statistics - borrower counts by category</p> 
<ul><li>during the previous calendar month</li> 
<li>at all system libraries</li> 
<li>grouped and sorted by borrower home library and borrower category</li> 
</ul><br /> 
<p>Notes:</p> 
<p></p> 
<p>This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p>Click here to download as a csv file</p> 
<p>#monthly #statistics #borrower #statistics #category</p> 
 
</div> 

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
) 

























