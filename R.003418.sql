/*
R.003418

----------

Name: 0005 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 16:34:33
Modified on: 2025-05-13 12:00:57
Date last run: 2025-10-03 12:36:52

----------

Public: 0
Expiry: 300

----------


  

    

      
        

          Report function:

        
      
      
        

          Monthly overview - collection statistics

          
            
              Shows item and holding counts for the previous calendar month
            
            
              At all Next Search Catalog libraries
            
            
              grouped and sorted by branch name
            
          

        
      
    

    
      
        

          Report notes:

        
      
      
        

          

            Generates data for:

            
              START_I = number of items owned on the first of the month
              END_I = number of items owned on the last day of the month
              ITEMS_ADD_L_M = items added last month
              ITEMS_DEL_L_M = items deleted last month
              TOTAL_HOLDINGS = number of bibliographic records where at least 1 item was held at this library on the first of the month
            

          

        
      
    

    
      
        

          Report instructions:

        
      
      
        

          

            
              Instructions go here
            

          

          

            
              More instructions go here
            

          

        
      
    

    

      
        

          Report external resources:

        
      

      
        

          
            


              Explanation of resource if necessary

              External resource 1

            
            


              Explanation of resource if necessary

              External resource 2

            
          

        
      
    

  

  

    Download this report as a csv file 

  

  

    

      #monthly 
      #statistics 
      #monthly_statistics
      #overview 
      #monthly_overview

    

  


----------
*/



SELECT 
  'BRANCH' AS BRANCH, 
  'START_I' AS START_I, 
  'END_I' AS END_I, 
  'ITEMS_ADD_L_M' AS ITEMS_ADD_L_M, 
  'ITEMS_DEL_L_M' AS ITEMS_DEL_L_M, 
  'TOTAL_HOLDINGS' AS TOTAL_HOLDINGS
UNION
SELECT 
  branches.branchname AS BRANCH, 
  Coalesce(Sum(DISTINCT START_ITEMS.count), 0) AS START_I, 
  Coalesce(Sum(DISTINCT END_ITEMS.count), 0) AS END_I, 
  Coalesce(Sum(DISTINCT ITEMS_ADDED.count), 0) AS ITEMS_ADD_L_M, 
  Coalesce(ITEMS_DELETED.count, 0) AS ITEMS_DEL_L_M, 
  Coalesce(Sum(DISTINCT TOTAL_HOLDINGS.count), 0) AS TOTAL_HOLDINGS 
FROM branches 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE items.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
      AND deleteditems.timestamp &gt;= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) START_ITEMS ON branches.branchcode = START_ITEMS.homebranch 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE items.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
      AND deleteditems.timestamp &gt;= AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) END_ITEMS ON branches.branchcode = END_ITEMS.homebranch 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY deleteditems.homebranch 
  ) ITEMS_ADDED ON branches.branchcode = ITEMS_ADDED.homebranch 
  LEFT JOIN ( 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY deleteditems.homebranch 
  ) ITEMS_DELETED ON branches.branchcode = ITEMS_DELETED.homebranch 
  LEFT JOIN ( 
    SELECT items.homebranch, 
      Count(DISTINCT items.biblionumber) AS count 
    FROM items 
    WHERE items.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(DISTINCT deleteditems.biblionumber) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
      AND deleteditems.timestamp &gt;= AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) TOTAL_HOLDINGS ON branches.branchcode = TOTAL_HOLDINGS.homebranch 
GROUP BY branches.branchname 
ORDER BY IF (BRANCH = 'BRANCH', ' AAAAA', BRANCH) 

























