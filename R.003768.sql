/*
R.003768

----------

Name: GHW - Monthly system wide statistics - Count of biblios added and deleted in the previous calendar month
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-13 17:04:41
Modified on: 2024-01-17 11:17:55
Date last run: 2023-10-16 14:26:41

----------

Public: 0
Expiry: 300

----------

 
 
   
 
    Generates a count of biblios added and deleted in the previous calendar month 
 
     
      Counts biblios added in the previous calendar month 
      At all libraries 
      grouped and sorted by library name 
     
 
   
 
   
 
     
 
     
 
     
     To be folded into 2024 spreadsheet. 
     
 
     
      If the library of the user that created or deleted a record cannot be determined, the creation/deletion is assigned to NEKLS 
     
   
   
 
   
 
     
       
        Click here to download as a csv file 
       
     
 
   
 
   
 
     
      #statistics 
      #monthly statistics 
      #biblio count 
     
 
   
 
   
 
 

----------
*/



SELECT 
  branchess.branchname, 
  total_added.Count_action_id AS BIBLIOS_ADDED, 
  total_deleted.Count_action_id AS BIBLIOS_DELETED 
FROM 
  ( 
    SELECT 
      branches.branchcode, 
      branches.branchname 
    FROM 
      branches 
  ) branchess 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, 'NEKLS') AS branchcode, 
      Count(action_logs.action_id) AS Count_action_id 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.user 
    WHERE 
      action_logs.module = 'CATALOGUING' AND 
      action_logs.action = 'ADD' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      action_logs.info = 'biblio' 
    GROUP BY 
      Coalesce(borrowers.branchcode, 'NEKLS') 
   ) total_added 
    ON total_added.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, 'NEKLS') AS branchcode, 
      Count(action_logs.action_id) AS Count_action_id 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.user 
    WHERE 
      action_logs.module = 'CATALOGUING' AND 
      action_logs.action LIKE 'DELE%' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      action_logs.info = 'biblio' 
    GROUP BY 
      Coalesce(borrowers.branchcode, 'NEKLS') 
  ) total_deleted 
    ON total_deleted.branchcode = branchess.branchcode 
GROUP BY 
  branchess.branchname 

























