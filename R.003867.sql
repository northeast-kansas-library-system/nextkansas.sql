/*
R.003867

----------

Name: GHW - Forbidden database fields
Created by: George Williams

----------

Group: -
     -

Created on: 2024-10-28 11:21:02
Modified on: 2025-05-19 11:40:46
Date last run: 2025-05-19 11:40:46

----------

Public: 0
Expiry: 300

----------



  
    Shows fields and words that you cannot use in Koha SQL reports
    Report created by: GHW
  

  

    
      
        
            Report function:
        
      

      
        
          
            Shows fields that include "forbidden" words as well as a list of "forbidden" words as defined in Report.pm
            in your  Koha database

            table name, column name, and forbidden words in the order they appear in Report.pm

          



        
      
    

    
      
        
          Report notes:
        
      
      
        

          
            Forbidden fields
            In order to protect password and authentication token data, trying to include some fields in a Koha SQL report will trigger an error message rather than allow that SQL to run.  Even though the data in most of the forbidden fields is usually encrypted, blocking these fields in SQL reports helps maintain the security of that data.  These field names are not case sensitive.
          

          
            Forbidden words
            SQL includes keywords that can trigger SQL functions that cause changes to the database.  Words like "DELETE" and "UPDATE," for example.  In order to prevent staff from accidentally modifying the Koha database structure (which would break Koha) some words cannot be used in Koha SQL reports.  These words are not case sensitive.
          

          

            
          

          

            
          

          

            
          

        
      
    

    
      
        
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
              ~Link 1~
            

            
              ~Link 2 description~
              ~Link 2~
            

            
              ~Link 3 description~
              ~Link 3~
            

            
              ~Link 4 description~
              ~Link 4~
            

            
              ~Link 5 description~
              ~Link 5~
            

          

        
      
    

  

  
    
      #Koha: 
      #database: 
      #forbidden: 







    
  

  
    
    Training page for report 3867 
    
    Printable instructions for report 3867 
    
    Training video for report 3867 
  

  
    
    Download this report as a csv file 
    
  

  
    
    Collapse report notes
    
  




----------
*/



SELECT 
  Concat( 
    '## Forbidden database fields in Koha SQL: Version ', 
    Format(systempreferences.value, 2) 
  ) AS `# FORBIDDEN_SQL_TERMS_IN_KOHA` 
FROM 
  systempreferences 
WHERE 
  systempreferences.variable = 'Version' 
UNION 
( 
  SELECT 
    Concat_Ws('.', Concat('- ', information_schema.COLUMNS.TABLE_NAME), 
    information_schema.COLUMNS.COLUMN_NAME) AS 
    'FIELDS_FORBIDDEN_IN_KOHA_REPORTS_MODULE' 
  FROM 
    information_schema.COLUMNS 
  WHERE 
    ( 
      information_schema.COLUMNS.COLUMN_NAME LIKE Concat('%pass', 'word%') OR 
      information_schema.COLUMNS.COLUMN_NAME LIKE Concat('%tok', 'en%') OR 
      information_schema.COLUMNS.COLUMN_NAME LIKE Concat('%uu', 'id%') OR 
      information_schema.COLUMNS.COLUMN_NAME LIKE Concat('%secr', 'et%') 
    ) AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%password_expiration_date%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%password_expiry_days%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%reset_password%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%change_password%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%min_password_length%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%require_strong_password%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%password_expiration_date%' 
  GROUP BY 
    Concat_Ws('.', 
      Concat('- ', information_schema.COLUMNS.TABLE_NAME), 
      information_schema.COLUMNS.COLUMN_NAME 
    ) 
) 
UNION 
SELECT 
  '## Forbidden words in Koha SQL reports' 
UNION 
SELECT 
  Concat('- U', 'PDATE') 
UNION 
SELECT 
  Concat('- D', 'ELETE') 
UNION 
SELECT 
  Concat('- D', 'ROP') 
UNION 
SELECT 
  Concat('- I', 'NSERT') 
UNION 
SELECT 
  Concat('- S', 'HOW') 
UNION 
SELECT 
  Concat('- C', 'REATE') 
LIMIT 500 

























