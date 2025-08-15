/*
R.000214

----------

Name: GHW - Items with important fields that are blank or have problematic values
Created by: -

----------

Group: -
     -

Created on: 2009-01-26 12:07:07
Modified on: 2025-05-16 23:54:36
Date last run: 2025-08-08 11:17:45

----------

Public: 0
Expiry: 500

----------



  
    Shows item records with important fields that are blank or may be problematic 
    Report created by: GHW
  

  

    
      
        
            Report function:
        
      

      
        
          
            Shows items currently in the catalog with the following fields left blank or having problematic data in the following fields:
            
            
              
                barcode (blank)
              
              
                item added dates in the future
              
              
                permanent shelving location (blank or cataloging, processing, or recently returned)
              
              
                item type (blank or unclassified)
              
              
                collection code (blank or unclassified)
              
              
                call number (blank)
              
              
                replacement price (blank)
              
            
            
            at the library you specify; and with the problem you specify
            grouped by biblio number and item number
            sorted by item home branch, location, item type, collection code, call number, author, and title
            contains links to the bibliographic record
          



        
      
    

    
      
        
          Report notes:
        
      
      
        

          
            Replaces reports:

             
              214 - Null Report - Missing Item Type report for all libraries (previous version) 
              1285 - Null Report - Missing Collection Codes all 
              1398 - Collection Codes to Fix 
              1401 - Item Types to Fix 
              1402 - Missing Replacement Prices 
              1404 - Shelving Locations to fix 
              1405 - Missing Call Number 
              1782 - Home or Current Branch is Null 
              1912 - Null report -- Missing Shelving Location all 
              3057 - GHW - Empty LOCATION/ITYPE/CCODES 
              3362 - GHW - Items at a library without a replacement cost 
            

          

          
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
              ~Link 1~
            

            
              ~Link 2 description~
              ~Link 2~
            

            
              ~Link 3 description~
              ~Link 3~
            

            
              ~Link 4 description~
              ~Link 4~
            

            
              ~Link 5 description~
              ~Link 5~
            

          

        
      
    

  

  
    
      #catalog_problems: 









    
  

  
    
    Training page for report 214 
    

    

  

  
    
    Download this report as a csv file 
    
  

  
    
    Collapse report notes
    
  




----------
*/



SELECT 
  Concat_WS('', 
    Concat( 
      'Bibliographic record' 
    ),
    '',
    Concat( 
      'Item record'
    )
  ) AS LINKS,
    Concat_Ws("", 
    If(items.barcode IS NULL, "Barcode is blank / ", ""), 
    If(items.dateaccessioned &gt; CURDATE(), "Date added is in the future / ", ""),
    If(plocs.lib IS NULL, "Permanent location is blank / ", 
      If(plocs.lib LIKE "%Cataloging%", "Permanent location = cataloging / ", 
        If(plocs.lib LIKE "%Processing%", "Permanent location = processing / ", 
          If(plocs.lib LIKE "%Recently%", "Permanent location = recently returned / ", "") 
        ) 
      ) 
    ), 
    If(ccodes.lib IS NULL, "Collection code is blank / ", 
      If(ccodes.lib LIKE "%(UN%", "Collection code = (Unclassified) / ", "") 
    ), 
    If(itypes.description IS NULL, "Item type is blank ", 
      If(itypes.description LIKE "%(UN%", "Item type = (Unclassified) / ", "") 
    ), 
    If(items.itemcallnumber IS NULL, "Call number is blank / ", ""), 
    If(items.replacementprice IS NULL, "Replacement price is blank / ", 
      If(items.replacementprice = 0, "Replacement price = $0.00 / ", "") 
    ) 
  ) AS "Problem field",
  biblio.biblionumber AS BIBLIO_NUMBER, 
  items.itemnumber, 
  items.barcode, 
  items.homebranch, 
  items.holdingbranch, 
  plocs.lib AS "PERMANENT LOCATION", 
  locs.lib AS LOCATION, 
  itypes.description AS ITYPE, 
  ccodes.lib AS CCODE, 
  items.itemcallnumber AS "Call number", 
  items.copynumber, 
  biblio.author, 
  Concat_Ws(" ", biblio.title, biblio.subtitle, biblioitems.number, 
  biblio.part_name) AS "Full title", 
  items.replacementprice AS "Replacement price", 
  items.dateaccessioned AS "Date added"  
FROM 
  items JOIN 
  biblio ON items.biblionumber = biblio.biblionumber JOIN 
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber AND 
      items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
  ) 
  plocs ON plocs.authorised_value = items.permanent_location LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
  ) 
  locs ON locs.authorised_value = items.location LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'ccode' 
  ) 
  ccodes ON ccodes.authorised_value = items.ccode LEFT JOIN 
  ( 
    SELECT 
      itemtypes.itemtype, 
      itemtypes.description 
    FROM 
      itemtypes 
  ) 
  itypes ON itypes.itemtype = items.itype 
WHERE 
  items.homebranch LIKE &lt;&gt; AND 
  (
    (items.barcode IS NULL) OR 
    (items.dateaccessioned &gt; CURDATE()) OR
    (plocs.lib IS NULL) OR 
    (plocs.lib LIKE "%Cataloging%") OR 
    (plocs.lib LIKE "%Processing%") OR 
    (plocs.lib LIKE "%Recently%") OR 
    (ccodes.lib IS NULL) OR 
    (ccodes.lib LIKE "%(UN%") OR 
    (itypes.description IS NULL) OR 
    (itypes.description LIKE "%(UN%") OR 
    (items.itemcallnumber IS NULL) OR 
    (items.replacementprice IS NULL)
  ) AND 
  Concat( 
    If(items.barcode IS NULL, "BE", ""), 
    If(items.dateaccessioned &gt; CURDATE(), "FD", ""), 
    If(plocs.lib IS NULL, "LE3", 
      If(plocs.lib LIKE "%Cataloging%", "LG3", 
        If(plocs.lib LIKE "%Processing%", "LG3", 
          If(plocs.lib LIKE "%Recently%", "LG3", "") 
        ) 
      ) 
    ), 
    If(ccodes.lib IS NULL, "CE3", 
      If(ccodes.lib LIKE "%(UN%", "CG3", "") 
    ), 
    If(itypes.description IS NULL, "IE3", 
      If(itypes.description LIKE "%(UN%", "IG3", "") 
    ), 
    If(items.itemcallnumber IS NULL, "NE", ""), 
    If(items.replacementprice IS NULL, "PE", 
      If(items.replacementprice = 0, "PE", "") 
    ) 
  ) LIKE Concat("%", &lt;&gt;, "%") 
GROUP BY 
  biblio.biblionumber, 
  items.itemnumber 
ORDER BY 
  items.homebranch, 
  PERMANENT_LOCATION, 
  ITYPE, 
  CCODE, 
  items.itemcallnumber, 
  items.copynumber, 
  biblio.author, 
  "Full title"

























