/*
R.003009

----------

Name: GHW - Accountlines by item barcode number (or description or note keyword)
Created by: George Williams

----------

Group: Fines/Fees
     -

Created on: 2017-10-23 09:30:01
Modified on: 2025-04-02 16:32:14
Date last run: 2025-08-14 16:04:01

----------

Public: 0
Expiry: 300

----------



  

    

      

        

            Report function:

        

      

      
        

          
            Shows accountline information for a particular item if the item's barcode number has been stored in the accountlines description or accountlines note fields
          

          
            
              Shows all accountlines related to the item barcode number specified
            
            
              Shows accountlines related to that item regardless as to which item owns the item or is owed the fee
            
            
              grouped and sorted by patron barcode number and accountline id
            
            
              links to the patron's fine history
            
           

        
      

    

    

      

        

          Report notes:

        

      

      
        
          
          

            
              This report was fully updated on January 21, 2022 to make it do a better job of search both the accountlines description and accountline notes at the same time.
            
            
              This report can only show the fee history on an item if the barcode number of the item was recorded in the description or note fields of the fee record. Currently Koha no longer stores this information automatically in the description or note fields.
            
            
              This report can only show the fines history on an item if the fee is unpaid or was paid less than 25 months ago.
            
            
              In some older version of Koha, the item barcode number was not always stored in the description field. If the item's barcode number was not stored in the description or note fields at the time the fee was created, this report cannot recover the data about the fee history.
            
            
              This report will show any entries in the patron's fee history - fees, credits, notes, writeoffs, etc. The only requirement is that the fee description or note contains the item barcode number you are searching for.
            

          

          

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

  

  

    

      #fees 
      #fines 
      #deleted items

    
    
  
  


----------
*/



SELECT
  Concat(
    'Borrower transactions'
  ) AS LINK,
  borrowers.cardnumber as BORROWER_CARDNUMBER,
  CONCAT_WS(
    ' // ', 
    accountlines.description, 
    accountlines.note
  ) as DESCRIP_NOTES,
  accountlines.date,
  Format(accountlines.amount, 2) AS amount
FROM
  accountlines
  JOIN borrowers ON accountlines.borrowernumber = borrowers.borrowernumber
WHERE
  CONCAT_WS(
    ', ', 
    accountlines.description, 
    accountlines.note
  ) LIKE CONCAT("%", &lt;&gt;, "%")
GROUP BY
  borrowers.cardnumber,
  accountlines.accountlines_id
ORDER BY
  accountlines.date DESC

























