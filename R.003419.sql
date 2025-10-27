/*
R.003419

----------

Name: 0010 - 2024_99_a_cy monthly_statistics 
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 16:59:13
Modified on: 2025-04-03 18:49:49
Date last run: 2025-10-03 12:42:42

----------

Public: 0
Expiry: 300

----------



  

    

      

        

            Report function:

        

      

      
        

          Monthly overview - circulation statistics 

          Shows circulation and renewal counts for the previous calendar month 
            At all Next Search Catalog libraries 
            grouped and sorted by branch name 
            

        
      

    

    

      

        

          Report notes:

        

      

      
        
          
          

            Generates data for: 
 
  CHECKOUT_RENEW_LM = all items checked out or renewed at this library last month 
  CHECKOUT_LM = all items checked out at this library last month 
  RENEW_LM = all items renewed at this library last month 
  RETURN_LM = all items returned at this library last month 
  CR_ADULT_LM includes items with these shelving locations: 
   
    Adult 
    ~Display - BALDWIN - Adult 
    ~Display - LEAVENWRTH - Adult 
    ~Display - PAOLA - Adult 
    Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Adult" locations 
   
  CR_YOUTH_LM includes items with these shelving locations: 
   
    Young adult 
    ~Display - BALDWIN - Young Adult 
    ~Display - LEAVENWRTH - Young adult 
    ~Display - PAOLA - Young adult 
    Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations 
    Childrens 
    ~Display - BALDWIN - Childrens 
    ~Display - LEAVENWRTH - Children's 
    ~Display - PAOLA - Children's 
    Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations 
    Cataloging 
    Processing Center 
    Any other situation where the recorded shelving location is "Recently returned" but the item's permanent location is ambiguous 
    Any items where the recorded shelving location is blank or unknown 
   


          

          

            SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."  If the shelving location is completely ambiguous, the circulation is counted as a "Youth" circulation in the CR_YOUTH_LM column. 

          

          

            This report and these notes updated on 2022.03.10 

          

        
      

    

    

      

        
          
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
  "BRANCH_NAME" AS BRANCH_NAME,
  "CHECKOUT_RENEW_LM" AS CHECKOUT_RENEW_LM,
  "CHECKOUT_LM" AS CHECKOUT_LM,
  "RENEW_LM" AS RENEW_LM,
  "RETURN_LM" AS RETURN_LM,
  "CR_ADULT_LM" AS CR_ADULT_LM,
  "CR_YOUTH_LM" AS CR_YOUTH_LM
UNION  
SELECT 
  branches.branchname AS BRANCH_NAME, 
  Coalesce(CIR_RENEW_LM.count, 0) AS CHECKOUT_RENEW_LM, 
  Coalesce(CKO_LM.count, 0) AS CHECKOUT_LM, 
  Coalesce(RENEW_LM.count, 0) AS RENEW_LM, 
  Coalesce(RETURN_LM.count, 0) AS RETURN_LM, 
  Coalesce(ADULT.count, 0) AS CR_ADULT_LM, 
  Coalesce(YOUTH.count, 0) AS CR_YOUTH_LM 
FROM 
  branches LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) CIR_RENEW_LM 
  ON branches.branchcode = CIR_RENEW_LM.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, 'L_AD'), 
        Coalesce(statistics.location, "L_AD") 
      ) LIKE "%AD%" 
    GROUP BY 
      statistics.branch 
    ) ADULT 
  ON branches.branchcode = ADULT.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, 'L_AD'), 
        Coalesce(statistics.location, "L_AD") 
      ) NOT LIKE "%AD%" 
    GROUP BY 
      statistics.branch 
    ) YOUTH 
  ON branches.branchcode = YOUTH.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'issue' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) CKO_LM 
  ON CKO_LM.branch = branches.branchcode LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'renew' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) RENEW_LM 
  ON RENEW_LM.branch = branches.branchcode 
  LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'return' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) RETURN_LM 
  ON RETURN_LM.branch = branches.branchcode 
GROUP BY 
  BRANCH_NAME 
ORDER BY 
  IF(BRANCH_NAME = "BRANCH_NAME", " BRANCH_NAME", BRANCH_NAME) 

























