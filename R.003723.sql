/*
R.003723

----------

Name: GHW - BASEHOR e-mails by date range
Created by: George Williams

----------

Group:  BASEHOR
     -

Created on: 2023-04-03 15:50:55
Modified on: 2025-07-03 10:34:34
Date last run: 2025-08-25 17:59:39

----------

Public: 0
Expiry: 300

----------

  
 
   
 
    Generates a list of e-mail addresses for borrowers with a BASEHOR home library based on borrowers date enrolled. 
 
     
      Shows borrower emails with an enrollment date during the date range you specify. 
      at BASEHOR 
      grouped and sorted by email address 
     
 
  

  

     

     
 
     
      BASEHOR was previously using report 555 to accomplish this function.
      

     
 
     
   
   
 
   
 
    
 
  

  

    
      #basehor 
      #email 
    

  
 
   

 

----------
*/



SELECT
  borrowers.email AS EMAIL
FROM
  borrowers JOIN
  categories ON borrowers.categorycode = categories.categorycode
WHERE
  borrowers.email NOT LIKE '' AND
  borrowers.branchcode = 'BASEHOR' AND
  borrowers.categorycode LIKE &lt;&gt; AND
  borrowers.dateenrolled BETWEEN &lt;&gt; AND &lt;&gt;
GROUP BY
  borrowers.email
LIMIT
  250

























