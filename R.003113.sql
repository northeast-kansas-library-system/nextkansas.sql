/*
R.003113

----------

Name: GHW - Deleted item dashboard
Created by: George Williams

----------

Group: -
     -

Created on: 2018-08-13 15:03:41
Modified on: 2025-04-02 16:24:45
Date last run: 2025-08-14 09:56:26

----------

Public: 0
Expiry: 300

----------



  Basic information about an item that has been deleted

  

    

      

        

            Report function:

        

      

      
        

        
          
            Shows items that are currently in the deleteditems table.  Item data is stored in the deleteditems table for 13 months after an item is deleted.
          
          
            Shows items with the barcode numbers you specify
          
          
            Grouped by itemnumber
          
          
            sorted by homebranch, item type, collection code, call number, author, and title
          
          
            Contains links to the items bibliographic record (if the bibliographic record has not been deleted) and links to a fines/fees report that can search by item barcode
          
         

        
      

    

    

      

        

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

  

  

    

      #deleted items

    
    
  
  


----------
*/



SELECT
  Concat_Ws(
    '',
    Concat('At the time of its deletion on:  ', deleteditems.timestamp, " this item's information was as follows:"),
    Concat('Item homebranch: ', deleteditems.homebranch),
    Concat('Current branch: ', deleteditems.holdingbranch),
    Concat('Shelving location: ', deleteditems.location),
    Concat('Item type: ', deleteditems.itype),
    Concat('Collection code: ', ccodes.lib),
    Concat('Call#: ', deleteditems.itemcallnumber),
    Concat('Author: ', Coalesce(biblio.author, deletedbiblio.author)),
    Concat('Title: ', Coalesce(biblio.title, deletedbiblio.title)),
    Concat('Item barcode: ', deleteditems.barcode),
    Concat('Item id number: ', deleteditems.itemnumber),
    Concat("Damaged status: ",
      If(
        deleteditems.damaged = 0,
        "-",
        If(
          deleteditems.damaged IS NULL,
          "-",
          damagedi.lib
        )
      )
    ),
    Concat("Lost status: ",
      If(
        deleteditems.itemlost = 0,
        "-",
        If(
          deleteditems.itemlost IS NULL,
          "-",
          Concat(losti.lib, " on ", deleteditems.itemlost_on)
        )
      )
    ),
    Concat("Withdrawn status: ",
      If(
        deleteditems.withdrawn = 0,
        "-",
        If(
          deleteditems.withdrawn IS NULL,
          "- ",
          Concat(deletedwithdrawni.lib, " on ", deleteditems.withdrawn_on)
        )
      )
    ),
    If(biblio.biblionumber IS NULL,
      "-- Bibliographic record has been deleted --",
      Concat(
        "Bibliographic record"
      )
    ),
    Concat(
      "See fee history for this item barcode number"
    )
  ) AS INFO
FROM
  deleteditems
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
  ) ccodes
    ON deleteditems.ccode = ccodes.authorised_value
  LEFT JOIN biblio
    ON deleteditems.biblionumber = biblio.biblionumber
  LEFT JOIN deletedbiblio
    ON deleteditems.biblionumber = deletedbiblio.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damagedi
    ON damagedi.authorised_value = deleteditems.damaged
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losti
    ON losti.authorised_value = deleteditems.itemlost
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) deletedwithdrawni
    ON deletedwithdrawni.authorised_value = deleteditems.withdrawn
WHERE
  deleteditems.barcode LIKE Concat("%", Trim(&lt;&gt;), "%")
GROUP BY
  deleteditems.itemnumber
ORDER BY
  deleteditems.homebranch,
  deleteditems.itype,
  ccodes.lib,
  deleteditems.itemcallnumber,
  Coalesce(biblio.author, deletedbiblio.author),
  Coalesce(biblio.title, deletedbiblio.title) 

























