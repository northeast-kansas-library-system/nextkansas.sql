/*
R.000582

----------

Name: OUTSTANDING Fines by patron home library
Created by:  Tongie Book Club

----------

Group: Circulation
     Charges

Created on: 2009-06-12 16:22:06
Modified on: 2025-06-02 14:09:26
Date last run: 2025-10-17 09:47:03

----------

Public: 0
Expiry: 0

----------



  
    Generates a list of all patrons with fees on their account
    Report created by: ~Author variable~
  

  

    
      
        
            Report function:
        
      

      
        
          
            Lists patrons that currently have an account balance due greater than $0.01
            ists patrons whose home library is the branchcode you specify - regardless of where the fees were generated.
            grouped by the borrower's card number
            sorted by the borrowers last name
            ~links to~
          

          ~Function notes~

        
      
    




































































































































  
    
      #fines: 
      #fees: 








    
  
















  
    
    Collapse report notes
    
  




----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  Format(Sum(accountlines.amountoutstanding), 2) AS AMT_DUE
FROM
  borrowers
  LEFT JOIN accountlines ON borrowers.borrowernumber = accountlines.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt;
GROUP BY
  borrowers.cardnumber
HAVING
  AMT_DUE &gt; 0
ORDER BY
  borrowers.surname

























