/*
R.003772

----------

Name: GHW - Bibliographic records created during a specific date range
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-16 17:47:06
Modified on: 2024-01-17 11:17:12
Date last run: 2024-08-28 08:33:18

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
 
  <div class="reportInfoContent"> 
 
    <p>Lists bibliographic records</p> 
 
    <ul> 
      <li>created during the date range you specify</li> 
      <li>by staff at the library you specify</li> 
      <li>grouped by biblio number and action logs ID</li> 
      <li>sorted by:
      <ol>
        <li>the library that created the record</li>
        <li>bibliographic shelving location (942$c)</li>
        <li>bibliographic item type (942$e)</li>
        <li>bibliographic collection code (942$h)</li>
      </ol>
    </li>
    <li>links to the bibliographic record</li>
    </ul> 
 
  </div> 
 
  <div class="reportInfoNotes"> 
 
    <p> 
 
    </p> 
 
    <p> 
      If a bibliographic record is created and then deleted in the period specified, you will be unable to link to the record.
    </p> 
 
    <p> 
 
    </p> 
 
  </div> 
 
  <div id="reportInfoLinks"> 
 
  </div> 
 
  <div id="reportInfoTags"> 
 
    <p style="display: none;"> 
      #bibliographic record 
      #by library 
    </p> 
 
  </div> 
 
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
 
</div> 

----------
*/



Select 
  branches.branchname,
  LOCS.lib AS LOCATION,
  itemtypes.description AS ITEM_TYPE,
  ccodes.lib AS COLLECTION_CODE,
  biblios.author,
  Concat_Ws('', biblios.title, biblios.subtitle) AS TITLE,
  biblios.frameworkcode,
  biblios.LINK
From action_logs
  Left Join borrowers On borrowers.borrowernumber = action_logs.user
  Left Join (
    Select 
      Concat(
        '<br />',
        '<a class="next_btn next_green noprint"',
        'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',
        biblio.biblionumber,
        '\" target="_blank">Go to biblio</a>'
      ) AS LINK,
      biblio.biblionumber,
      biblioitems.agerestriction,
      biblioitems.itemtype,
      biblioitems.cn_class,
      biblio.author,
      biblio.title,
      biblio.subtitle,
      biblio.frameworkcode
    From biblio
      Join biblioitems On biblioitems.biblionumber = biblio.biblionumber
    Where 
      biblio.datecreated Between <<The beginning of the day on|date>> and (<<and the end of the day on date2|date>> + Interval 1 Day)
    Group By biblio.biblionumber
    Union
    Select 
      Concat('Deleted on ', deletedbiblio.timestamp) AS BIBLIOS,
      deletedbiblio.biblionumber,
      deletedbiblioitems.agerestriction,
      deletedbiblioitems.itemtype,
      deletedbiblioitems.cn_class,
      deletedbiblio.author,
      deletedbiblio.title,
      deletedbiblio.subtitle,
      deletedbiblio.frameworkcode
    From deletedbiblio
      Join deletedbiblioitems On deletedbiblioitems.biblionumber = deletedbiblio.biblionumber
    Where 
      deletedbiblio.datecreated Between <<The beginning of the day on|date>> and (<<and the end of the day on date2|date>> + Interval 1 Day)
    Group By deletedbiblio.biblionumber
  ) biblios 
    On biblios.biblionumber = action_logs.object
  Join branches On borrowers.branchcode = branches.branchcode
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'LOC'
  ) LOCS 
    On LOCS.authorised_value = biblios.agerestriction
  Left Join itemtypes 
    On itemtypes.itemtype = biblios.itemtype
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'CCODE'
  ) ccodes 
    On ccodes.authorised_value = biblios.cn_class
Where 
  action_logs.module = 'CATALOGUING'
  And action_logs.action = 'ADD'
  And action_logs.info = 'biblio'
  And branches.branchcode Like <<Choose your library|LBRANCH>>
  And biblios.agerestriction Like <<Choose a bibliographic level shelving location|bibloc:all>>
  And biblios.itemtype Like <<Choose a bibliographic level item type|bibitype:all>>
  And biblios.cn_class Like <<Choose a bibliographic level collection code|CCODE:all>>
  And action_logs.timestamp Between <<The beginning of the day on|date>> and (<<and the end of the day on date2|date>> + Interval 1 Day)
Group By 
  action_logs.action_id,
  biblios.biblionumber  
Order By 
  branches.branchname,
  LOCATION,
  ITEM_TYPE,
  COLLECTION_CODE,
  biblios.author,
  TITLE,
  biblios.LINK

























