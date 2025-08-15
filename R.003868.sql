/*
R.003868

----------

Name: GHW - Waiting requests cancelled in the last 7 days
Created by: George Williams

----------

Group: -
     -

Created on: 2024-11-08 17:56:09
Modified on: 2025-05-19 10:12:50
Date last run: 2025-05-19 10:14:11

----------

Public: 0
Expiry: 300

----------



  
    Shows items cancelled from hold shelf in the last 7 days
    Report created by: GHW
  

  

    
      
        
            Report function:
        
      

      
        
          
            Shows the items waiting on the hold shelf for pickup where the hold was cancelled in the last 7 days
            on the hold shelf at the library you specify
            grouped by reserve_id number
            sorted by library where the item was held and the card number of the borrower the item was held for
            links to the bibliogrpahic record of the item
          

        
      
    

    
      
        
          Report notes:
        
      
      
        

          
            HELD_FOR_CARD_NUMBER
            The report only shows the first 3 letters of the borrower's lat name and the last 6 digits of the borrower's card number in order to protect the borrower's privacy.
          

          
            CANCELLED_BY
            The report shows the home library and borrower category of the user that cancelled the request
          

          
            CANCELLED_USING_THE
              API = probably cancelled using Aspen Discovery or Aspen Lida  Cron job = cancelled automatically by Koha  Koha staff client = A library staff member cancelled this request  OPAC = Cancelled via the Koha OPAC
          

          
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
              ~Link 1~
            

            
              ~Link 2 description~
              ~Link 2~
            

            
              ~Link 3 description~
              ~Link 3~
            

            
              ~Link 4 description~
              ~Link 4~
            

            
              ~Link 5 description~
              ~Link 5~
            

          

        
      
    

  

  
    
      #requests: 
      #holds: 
      #hold shelf: 
      #cancellations: 

    
  

  
    
    Training page for report 3868 
    
    Printable instructions for report 3868 
    
    Training video for report 3868 
  

  
    
    Download this report as a csv file 
    
  

  
    
    Collapse report notes
    
  




----------
*/



SELECT
  branches.branchname AS HELD_AT,
  Concat_Ws('', 
    Concat(Left(borrowers.surname, 3)),
    Concat(Right(borrowers.cardnumber, 6))
  ) AS HELD_FOR_CARD_NUMBER,
  Concat_Ws('', 
    Concat(homebranches.branchname), 
    Concat(locs.lib),
    Concat(itemtypes.description), 
    Concat(ccodes.lib),
    Concat(items.itemcallnumber), 
    Concat(biblio.author), 
    Concat(biblio.title),
    Concat(items.barcode)
  ) AS ITEM_HELD,
  old_reserves.cancellationdate AS CANCELLED_ON,
  Concat_Ws(' ', 
    staffs.branchcode, 
    staffs.categorycode
  ) AS CANCELLED_BY,
  CASE
    WHEN action_logs.interface = 'api' THEN 'API'
    WHEN action_logs.interface = 'cron' THEN 'Cron job'
    WHEN action_logs.interface = 'intranet' THEN 'Koha staff client'
    WHEN action_logs.interface = 'opac' THEN 'OPAC'
    ELSE action_logs.interface
  END AS CANCELLED_USING_THE,
  Concat( 
    'Go to title' 
  ) AS LINK_TO_RECORD
FROM
  old_reserves JOIN
  action_logs ON action_logs.object = old_reserves.reserve_id RIGHT JOIN
  branches ON old_reserves.branchcode = branches.branchcode LEFT JOIN
  items ON old_reserves.itemnumber = items.itemnumber JOIN
  biblio ON items.biblionumber = biblio.biblionumber LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) locs 
    ON locs.authorised_value = items.permanent_location 
  LEFT JOIN branches homebranches 
    ON homebranches.branchcode = items.homebranch 
  LEFT JOIN itemtypes 
    ON itemtypes.itemtype = items.itype 
  LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
  ) ccodes ON ccodes.authorised_value = items.ccode 
  LEFT JOIN borrowers 
    ON borrowers.borrowernumber = old_reserves.borrowernumber 
  LEFT JOIN borrowers staffs 
    ON staffs.borrowernumber = action_logs.user
WHERE
  branches.branchcode LIKE &lt;&gt; AND
  action_logs.module = 'HOLDS' AND
  action_logs.action = 'CANCEL' AND
  old_reserves.found = 'W' AND
  old_reserves.cancellationdate &gt; Now() - INTERVAL 7 DAY
GROUP BY
  old_reserves.reserve_id
ORDER BY
  HELD_AT,
  HELD_FOR_CARD_NUMBER

























