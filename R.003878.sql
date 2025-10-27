/*
R.003878

----------

Name: Repair work
Created by: George Williams

----------

Group: -
     -

Created on: 2025-03-11 16:16:33
Modified on: 2025-05-15 14:30:44
Date last run: 2025-08-22 17:18:48

----------

Public: 0
Expiry: 300

----------



  Title/introduction/etc.

  

    

      
        

            Report function:

        
      
      
        

           
            
              When
             
            
              Whose Stuff
             
            
              grouped by
             
            
              sorted by
             
            
              links
             
           

        
      
    

    
      
        

          Report notes:

        
      
      
        
          
          

            Notes go here

          

          

            More notes go here

          

        
      
    

    
      
        
          
          Report instructions:

        
      
      
        

          

            
              Instructions go here
            

          

          

            
              More instructions go here
            

          

        
      
    

    

      
        

          Report external resources:

        
      

      
        

          
            

              Explanation of resource if necessary

              External resource 1

            
            

              Explanation of resource if necessary

              External resource 2

            
          

        
      
    
    
  

  

    Download this report as a csv file 

  

  

    

      #tags_go_here

    
    
  

  

    Training page for this report 

    Printable instructions for this report 

  

  

    Collapse report notes

  


----------
*/



Select
  Concat( 
    'Go to title',
    '', 
    'Edit item' 
  ) AS LINKS,
  If(coalesce(items.dateaccessioned, '1900-01-01') &lt; '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d')) AS DATE_ADDED,
  Count(items.itemnumber) As Count_itemnumber
From
  items
Group By
  If(coalesce(items.dateaccessioned, '1900-01-01') &lt; '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d'))
Order By
  If(coalesce(items.dateaccessioned, '1900-01-01') &lt; '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d')) ASC

























