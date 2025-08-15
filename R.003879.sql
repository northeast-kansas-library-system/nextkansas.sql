/*
R.003879

----------

Name: GHW - Flexible Shelflist Report
Created by: George Williams

----------

Group: -
     -

Created on: 2025-03-12 00:03:17
Modified on: 2025-04-30 17:09:23
Date last run: 2025-08-15 11:39:09

----------

Public: 0
Expiry: 300

----------



  

    

      

        

            Report function:

        

      

      
        

          Generates a list of items owned by a library and allows options for filtering.

           
            
              Shows items that are currently in Next
             
            
              at the library you specify
             
            
              grouped by itemnumber
             
            
              sorted by:
              
                Home library 
                Shelving location 
                Item type 
                Collection code 
                Call number 
                Author 
                Title 
                itemnumber 
              
             
            
              links to the bibliographic record and item record
             
           

        
      

    

    

      

        

          Report notes:

        
      

      
        
          
          

            This report handles item added dates, date last borrowed dates, and date last seen dates in the following manner:
            
              
                Item added dates that are older than 2000 are filtered as if they were added on January 2, 2000
                this means that if you want to search for items added before January 1, 2000, enter January 1, 2000 as date1
              
              
                Item added dates that are newer than today are filtered as if they were added today 
                this means that if you want to search for items that were added after today (i.e. dates with mistakes), enter tomorrow as date2
              
              
                Date last borrowed dates that are older than 2000 or are blank are filtered as if they were added on January 2, 2000 
                this means that if you want to search for items that have a date last borrowed older than January 1, 2000 or a blank date last borrowed, enter January 1, 2000 as date1
              
              
                Date last seen dates that are blank or older than 2000 are filtered as if they were added on January 2, 2000 
                this means that if you want to search for items that have a date last seen older than January 1, 2000 or a blank date last seen, enter January 1, 2000 as date1
              
            

            All of these dates will still show the actual dates in the appropriate columns, but you will not need to adjust the filters earlier than January 1, 2000 in order to identify dates prior to 2000.  If you run this report and specify dates before January 1, 2000, you will be able to see these items, but you cannot specify dates older than January 1, 2000, and expect to be limited to the specified date range.

          

          

            Publication year data comes from the 264$c or 260$c subfield.  If the data in 264$c or 260$c is not entered as a 4 digit year, or contains non-standard date information, the data may be problematic.  If 264$c and/or 260$c subfields are blank, the result in this report will be blank.

            For example, if the 264$c is entered as "Nineteen Seventy Five", the data will be weird.  If the 264$c is "Copyright 1975," the data will be weird.  If the 264$c is &copy;1975, the date should be as expected, but if it's &#128197;1975, the data will be problematic.

          

          

            Replaces these reports

            
              2731 (GHW - Flexible Shelflist Report)
              664 (Full Shelf List)
              2686 (Collection Code Super Weeder)
              1013 (Item Type Super Weeder)
              1442 (Super Weeder by Callnumber)
              2471 (BCPL.SuperWeeder.by.Callnumber)
              1017 (Items with NO checkouts (all items))
              1151 (Date last borrowed, Call number and Title limited by Item type)
              1426 (Last seen on a specific date or earlier)
              1807 (Items with NO checkouts -- limited by CCode)
              2202 (Items with NO checkouts (limited to a collection code and location))
              2203 (Items with NO checkouts (limited to a collection code))
              2241 (Last Seen Date, limited by Collection Code)
              2392 (Date last borrowed, Call number and Title limited by Ccode and Location)
              2411 (Date last borrowed)
              1408 (Shelf List of Specific Item Type)
              1409 (Shelf List of Specific CCode and Location)
              1410 (Shelf List of Specific Item Type and Location)
              3014 (GHW - Shelflist with left anchored call number limit)
              2809 (GHW - List of items with display locations)
              886 Videogames Circ List
              536 New acquisitions for a specific month
            

          

        
      

    

    

      

        
          
          Report instructions:

        
      

      
        

          

            
              Instructions go here
            

          

          

            
              More instructions go here
            

          

        
      

    

    

      

        

          Report external resources:

        

      

      
        

          
            

              Explanation of resource if necessary

              External resource 1

            
            

              Explanation of resource if necessary

              External resource 2

            
          

        
      

    
    
  

  

    Download this report as a csv file 

  

  

    

      #corereport;
      #2731; 
      #shelflist;
      #lost;
      #missing;
      #status;

    
    
  

 



----------
*/



Select 
Concat(
    'Go to title',
    '&nbsp;',
    'Edit item',
    '&nbsp;',
    'View title inAspen Discovery'
  ) As LINK_ONE,
  item_information.biblionumber As BIBLIO_NUMBER,
  item_information.itemnumber As ITEM_NUMBER,
  item_information.barcode As BARCODE,
  home_branches.branchname As HOME_LIBRARY,
  current_branches.branchname As CURRENT_LIBRARY,
  permanent_locations.lib As ITEM_PERMANENT_LOCATION,
  locations.lib As ITEM_CURRENT_LOCATION,
  item_information.BIB_LOC AS BIB_LOCATION,
  itemtypes.description As ITEM_ITYPE,
  item_information.BIB_ITYPE AS BIB_ITYPE,
  ccodes.lib As ITEM_COLLECTION_CODE,
  item_information.BIB_CCODE AS BIB_COLLECTION_CODE,
  item_information.itemcallnumber As CALL_NUMBER,
  item_information.author As AUTHOR,
  item_information.FULL_TITLE,
  item_information.publicationyear,
  item_information.isbn,
  item_information.issn,
  item_information.UPC,
  item_information.dateaccessioned,
  item_information.datelastborrowed,
  item_information.datelastseen,
  item_information.issues,
  item_information.renewals,
  item_information.CKO_PLUS_RENEW,
  last_twelve.count As CKO_LAST_12M,
  item_information.CHECKED_OUT_NOW,
  not_loans.lib As NOT_FOR_LOAN,
  item_information.STATUS_PROBLEMS,
  Concat_Ws(
    '',
    If(
      Coalesce(damageds.lib, '') = '',
      '',
      Concat_Ws(
        '',
        damageds.lib,
        ' -- ',
        Coalesce(item_information.damaged_on, 'Date not known')
      )
    ),
    If(item_information.status_score &gt; 18, ' / ', ''),
    If(
      Coalesce(losts.lib, 'x') = 'x',
      '',
      Concat_Ws(
        '',
        losts.lib,
        ' -- ',
        Coalesce(
          item_information.itemlost_on,
          'Date not known'
        )
      )
    ),
    If(
      item_information.status_score = 18,
      ' / ',
      If(item_information.status_score = 35, ' / ', '')
    ),
    If(
      Coalesce(withdrawns.lib, '') = '',
      '',
      Concat_Ws(
        '',
        withdrawns.lib,
        ' -- ',
        Coalesce(item_information.withdrawn_on, 'Date not known')
      )
    )
  ) As STATUSES,
  item_information.itemnotes,
  item_information.itemnotes_nonpublic,
  item_information.copynumber,
  item_information.replacementprice,
  local_count.Count_itemnumber As LOCAL_COPIES,
  system_count.Count_itemnumber As SYSTEM_COPIES,
  Concat(
    'Go to title',
    '',
    'Edit item'
  ) As LINK_TWO
From (
    Select items.biblionumber,
      items.itemnumber,
      IF(
        LEFT(
          Trim(items.barcode), 1
        ) = '0', 
        Concat_Ws('', '-', items.barcode, '-'), 
        Trim(items.barcode)
      ) As barcode,
      items.homebranch,
      items.holdingbranch,
      items.permanent_location,
      items.location,
      items.itype,
      items.ccode,
      items.itemcallnumber,
      biblio.author,
      Concat_Ws(
        " ",
        biblio.title,
        ExtractValue(
          biblio_metadata.metadata,
          '//datafield[@tag="245"]/subfield[@code="h"]'
        ),
        ExtractValue(
          biblio_metadata.metadata,
          '//datafield[@tag="245"]/subfield[@code="b"]'
        ),
        ExtractValue(
          biblio_metadata.metadata,
          '//datafield[@tag="245"]/subfield[@code="p"]'
        ),
        ExtractValue(
          biblio_metadata.metadata,
          '//datafield[@tag="245"]/subfield[@code="n"]'
        )
      ) As FULL_TITLE,
      biblioitems.publicationyear,
      biblioitems.isbn,
      biblioitems.issn,
      ExtractValue(
        biblio_metadata.metadata,
        '//datafield[@tag="024"]/subfield[@code="a"]'
      ) As UPC,
      ExtractValue(
          biblio_metadata.metadata,
          '//datafield[@tag="942"]/subfield[@code="e"]'
      ) AS BIB_LOC,
      ExtractValue(
        biblio_metadata.metadata,
        '//datafield[@tag="942"]/subfield[@code="c"]'
      ) AS BIB_ITYPE,
      ExtractValue(
        biblio_metadata.metadata,
        '//datafield[@tag="942"]/subfield[@code="h"]'
      ) AS BIB_CCODE,
      items.dateaccessioned
      ,
      If(
        Coalesce(items.dateaccessioned, '2000-01-02') &lt; '2000-01-01', 
        '2000-01-02', 
        If(
          items.dateaccessioned &gt; Now(), 
          '2000-01-03', 
          items.dateaccessioned
        )
      ) AS dateaccessioned_normalized,
      items.datelastborrowed,
      items.datelastseen,
      items.issues,
      items.renewals,
      (
        Coalesce(items.issues, 0) + Coalesce(items.renewals, 0)
      ) As CKO_PLUS_RENEW,
      If(items.onloan Is Null, 'No', 'Yes') As CHECKED_OUT_NOW,
      items.notforloan,
      If(
        Sum(
          Coalesce(items.damaged, 0) + Coalesce(items.itemlost, 0) + Coalesce(items.withdrawn, 0)
        ) = 0,
        'No',
        'Yes'
      ) As STATUS_PROBLEMS,
      items.damaged,
      items.damaged_on,
      items.itemlost,
      items.itemlost_on,
      items.withdrawn,
      items.withdrawn_on,
      If((items.damaged * 10) != 0, 17, 0) As damage_score,
      If((items.itemlost * 10) != 0, 11, 0) As lost_score,
      If((items.withdrawn * 10) != 0, 7, 0) As withdrawn_score,
      (
        If((items.damaged * 10) != 0, 17, 0) + If((items.itemlost * 10) != 0, 11, 0) + If((items.withdrawn * 10) != 0, 7, 0)
      ) As status_score,
      items.itemnotes,
      items.itemnotes_nonpublic,
      items.copynumber,
      items.replacementprice,
      '' As LOCAL_COPIES,
      '' As SYSTEM_COPIES
    From items
      Join biblio On items.biblionumber = biblio.biblionumber
      Inner Join biblio_metadata On biblio_metadata.biblionumber = biblio.biblionumber
      Inner Join biblioitems On biblioitems.biblionumber = biblio.biblionumber
    Where 
      Coalesce(items.homebranch, 'NEKLS') LIKE &lt;&gt; AND
      Coalesce(items.permanent_location, "-") LIKE &lt;&gt; AND 
      Coalesce(items.itype, 'PUNC') LIKE &lt;&gt; AND
      Coalesce(items.ccode, 'XXX') LIKE &lt;&gt; AND 
      Coalesce(items.itemcallnumber, '-') LIKE Concat(&lt;&gt;, "%") AND 
      IF(Coalesce(items.notforloan, 0) = 0, 'X', items.notforloan) REGEXP &lt;&gt; AND 
      (
        If(
          Coalesce(items.dateaccessioned, '2000-01-02') &lt; '2000-01-01', 
          '2000-01-02', 
          If(
            items.dateaccessioned &gt; Now(), 
            Cast(now() As Date), 
            items.dateaccessioned
          )
        ) BETWEEN &lt;&gt; AND &lt;&gt;
      ) AND 
      (
        If( 
          Coalesce(Year(Coalesce(items.datelastborrowed)), '1999') &lt; '2000', 
          '2000-01-02', 
          items.datelastborrowed 
        ) BETWEEN &lt;&gt; AND &lt;&gt;
      ) AND 
      (
        If( 
          Coalesce(Year(Coalesce(items.datelastseen)), '1999') &lt; '2000', 
          CAST('2000-01-02' AS DATE), 
          Date(items.datelastseen) 
        ) BETWEEN &lt;&gt; AND &lt;&gt; 
      )
    Group By items.itemnumber
  ) item_information
  Left Join branches home_branches 
    On home_branches.branchcode = item_information.homebranch
  Left Join branches current_branches 
    On current_branches.branchcode = item_information.holdingbranch
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'LOC'
  ) permanent_locations 
    On permanent_locations.authorised_value = item_information.permanent_location
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'LOC'
  ) locations 
    On locations.authorised_value = item_information.location
  Left Join itemtypes 
    On itemtypes.itemtype = item_information.itype
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'CCODE'
  ) ccodes 
    On ccodes.authorised_value = item_information.ccode
  Left Join (
    Select statistics.itemnumber,
      Count(*) As count
    From statistics
    Where statistics.datetime &lt; CurDate() - Interval 1 Year
      And (
        statistics.type = 'issue'
        Or statistics.type = 'renew'
      )
    Group By statistics.itemnumber
  ) last_twelve 
    On last_twelve.itemnumber = item_information.itemnumber
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'not_loan'
  ) not_loans 
    On not_loans.authorised_value = item_information.notforloan
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'damaged'
  ) damageds 
    On damageds.authorised_value = item_information.damaged
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'lost'
  ) losts 
    On losts.authorised_value = item_information.itemlost
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'withdrawn'
  ) withdrawns 
    On withdrawns.authorised_value = item_information.withdrawn
  Left Join (
    Select items.biblionumber,
      Count(items.itemnumber) As Count_itemnumber,
      items.homebranch
    From items
    Where 
      Coalesce(items.homebranch, 'NEKLS') LIKE &lt;&gt;
    Group By items.biblionumber
  ) local_count 
    On local_count.biblionumber = item_information.biblionumber
  Left Join (
    Select items.biblionumber,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Group By items.biblionumber
  ) system_count 
    On system_count.biblionumber = item_information.biblionumber
WHERE
  Coalesce(item_information.STATUS_PROBLEMS, 'No') LIKE &lt;&gt; AND
  Coalesce(item_information.damaged, 0) LIKE &lt;&gt; AND
  Coalesce(losts.lib_opac, '-') LIKE &lt;&gt; AND 
  Coalesce(item_information.withdrawn, 0) LIKE &lt;&gt; AND 
  Coalesce(item_information.CKO_PLUS_RENEW, 0) &lt;= &lt;&gt; AND 
  Coalesce(item_information.CHECKED_OUT_NOW, 'No') LIKE &lt;&gt; AND 
  Coalesce(local_count.Count_itemnumber, 0) &gt;= &lt;&gt; AND 
  Coalesce(system_count.Count_itemnumber, 0) &gt;= &lt;&gt;
Order By 
  HOME_LIBRARY,
  ITEM_PERMANENT_LOCATION,
  ITEM_ITYPE,
  ITEM_COLLECTION_CODE,
  CALL_NUMBER,
  AUTHOR,
  item_information.FULL_TITLE,
  ITEM_NUMBER DESC

























