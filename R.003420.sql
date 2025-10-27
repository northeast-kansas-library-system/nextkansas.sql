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
Date last run: 2025-10-03 12:46:29

----------

Public: 0
Expiry: 300

----------

 
Monthly overview - borrower statistics 
Shows borrower counts for the previous calendar month 
At all Next Search Catalog libraries 
grouped and sorted by branch name 
 
Notes: 
 
Generates data for: 
 
  BORROWER_ACCT_USED_LM = number of borrower accounts used to check out materials last month 
  TOTAL_BORROWERS = number of total borrowers with this home library 
  B_ADDED_LM = number of borrowers with this home library added last month 
  B_RENEWED_LM = number of borrowers with this home library renewed last month 
  B_DELETED_LM = number of borrowers with this home library deleted last month 
 
 
These counts are current at the time the report is run (which for Next Search Catalog is usually between 12:01 a.m. and 4:00 a.m. on the first day of the month). 
 
This report and these notes updated on 2022.03.10 
 
Click here to download as a csv file 
#monthly #statistics #overview #monthly_overview 
 
 

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
      Count(*) AS COUNT 
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
      Count(*) AS COUNT 
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
      Count(*) AS COUNT 
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
      Count(*) AS COUNT 
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

























