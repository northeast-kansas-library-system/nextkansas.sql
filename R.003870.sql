/*
R.003870

----------

Name: GHW - count of items shipped from a library
Created by: George Williams

----------

Group: -
     -

Created on: 2024-12-19 16:15:55
Modified on: 2025-05-19 09:57:32
Date last run: 2025-05-19 09:58:22

----------

Public: 0
Expiry: 300

----------



  
    Gives a count of items shipped for transfer
    Report created by: GHW
  

  

    
      
        
          Report function:
        
      

      
        
          
            Shows items shipped during the date range you specify
            shipped from the library you specify
            grouped by shipping library, date and time shipped, date shipped, and date range
            sorted by shipping library, date and time shipped

          

        
      
    

    
      
        
          Report notes:
        
      
      
        

          
            ~Notes heading 1~
            ~Notes sample 1~
          

          
            ~Notes heading 2~
            ~Notes sample 2~
          

          
            ~Notes heading 3~
            ~Notes sample 3~
          

          
            ~Notes heading 4~
            ~Notes sample 4~
          

          
            ~Notes heading 5~
            ~Notes sample 5~
          

        
      
    

    
      
        
          Report instructions:
        
      
      
        

          
            ~heading 1~
            
              Instructions go here
            
          

          
            ~heading 2~
            
              Instructions go here
            
          

          
            ~heading 3~
            
              Instructions go here
            
          

          
            ~heading 4~
            
              Instructions go here
            
          

          
            ~heading 5~
            
              Instructions go here
            
          

        
      
    

    
      
        
          Report external resources:
        
      

      
        

          

            
            ~Link 1 description~
            ~Link
              1~
            

            
            ~Link 2 description~
            ~Link
              2~
            

            
            ~Link 3 description~
            ~Link
              3~
            

            
            ~Link 4 description~
            ~Link
              4~
            

            
            ~Link 5 description~
            ~Link
              5~
            

          

        
      
    

  

  
    
      #transfers:
      #shipped:
      #count of items:

    
  

  
    
    Training page for
      report 3870 
    
    Printable
      instructions for report 3870 
    
    Training video for
      report 3870 
  

  
    
    Download this report
      as a csv file 
    
  

  
    
    Collapse
      report notes
    
  



----------
*/



SELECT
  branches.branchname AS FROM_BRANCH,
  Date_Format(branchtransfers.datesent, "%W") AS DAY,
  Date_Format(branchtransfers.datesent, "%Y-%m-%d--%H:%i") AS DATE_TIME,
  Count(branchtransfers.branchtransfer_id) AS COUNT_OF_ITEMS_SHIPPED,
  '' DAILY_ITEMS_SHIPPED,
  '' DATE_RANGE_ITEMS_SHIPPED
FROM
  branchtransfers JOIN
  branches ON branches.branchcode = branchtransfers.frombranch
WHERE
  branchtransfers.frombranch Like &lt;&gt; AND
  branchtransfers.datesent BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day)
GROUP BY
  Date_Format(branchtransfers.datesent, "%W"),
  Date_Format(branchtransfers.datesent, "%Y-%m-%d--%H:%i"),
  branchtransfers.frombranch
UNION
(SELECT
  branches.branchname AS FROM_BRANCH,
  Date_Format(branchtransfers.datesent, "%W") AS DAY,
  Concat_Ws('', Date_Format(branchtransfers.datesent, "%Y-%m-%d"),
  ' - Daily Total') AS DATE_TIME,
  '' AS COUNT_OF_ITEMS_SHIPPED,
  Count(branchtransfers.branchtransfer_id) AS DAILY_ITEMS_SHIPPED,
  '' DATE_RANGE_ITEMS_SHIPPED
FROM
  branchtransfers JOIN
  branches ON branches.branchcode = branchtransfers.frombranch
WHERE
  branchtransfers.frombranch Like &lt;&gt; AND
  branchtransfers.datesent BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day)
GROUP BY
  Date_Format(branchtransfers.datesent, "%W"),
  Concat_Ws('', Date_Format(branchtransfers.datesent, "%Y-%m-%d"),
  ' - Daily Total'),
  branchtransfers.frombranch)
UNION
(SELECT
  branches.branchname AS FROM_BRANCH,
  '' AS DAY,
  ' Total for date range' AS DATE_TIME,
  '' AS COUNT_OF_ITEMS_SHIPPED,
  '' DAILY_ITEMS_SHIPPED,
  Count(branchtransfers.branchtransfer_id) AS DATE_RANGE_ITEMS_SHIPPED
FROM
  branchtransfers JOIN
  branches ON branches.branchcode = branchtransfers.frombranch
WHERE
  branchtransfers.frombranch Like &lt;&gt; AND
  branchtransfers.datesent BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day)
GROUP BY
  branchtransfers.frombranch)
ORDER BY
  FROM_BRANCH,
  DATE_TIME DESC

























