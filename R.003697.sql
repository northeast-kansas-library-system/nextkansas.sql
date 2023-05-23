/*
R.003697

----------

Name: GHW - Circulation and renewal count in date range by library, location, item type, and collection code
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-01-25 15:13:38
Modified on: 2023-01-25 17:07:29
Date last run: 2023-03-22 14:28:19

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
  <p>Counts circulation by date range directly from the statistics table</p>
  <ul>
    <li>during the date range you specify</li>
    <li>checked out or renewed at the library you specify</li>
    <li>grouped and sorted by branchname, branchcode, LOCATION, LOCATION_CODE, ITEM_TYPE, ITEM_TYPE_CODE, COLLECTION_CODE_DESCRIPTION, and COLLECTION_CODE_CODE</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Can gather statistical data that the statistics wizard cannot</p>
  <p></p>
  <p>This report relies on data from the statistics table.  Data in the statistics table is only kept for 25 months, so if you set a start date or an end date more than 25 months ago, you will not be able to retrieve accurate data.</p>
  <p></p>
  <p class= "notetags" style="display: none;">#statistics #library #location #itype #ccode</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



Select  
  branchesscodess.branchname, 
  branchesscodess.branchcode, 
  branchesscodess.LOCATION, 
  branchesscodess.LOCATION_CODE, 
  branchesscodess.ITEM_TYPE, 
  branchesscodess.ITEM_TYPE_CODE, 
  branchesscodess.COLLECTION_CODE_DESCRIPTION, 
  branchesscodess.COLLECTION_CODE_CODE, 
  statistics.type, 
  Count(statistics.datetime) As COUNT 
From ( 
    Select  
      branches.branchcode, 
      branches.branchname, 
      locss.lib As LOCATION, 
      locss.authorised_value As LOCATION_CODE, 
      itemtypes.description As ITEM_TYPE, 
      itemtypes.itemtype As ITEM_TYPE_CODE, 
      ccodess.lib As COLLECTION_CODE_DESCRIPTION, 
      ccodess.authorised_value As COLLECTION_CODE_CODE 
    From branches, 
      ( 
        Select authorised_values.category, 
          authorised_values.authorised_value, 
          authorised_values.lib, 
          authorised_values.lib_opac 
        From authorised_values 
        Where authorised_values.category = 'LOC' 
      ) locss, 
      itemtypes, 
      ( 
        Select authorised_values.category, 
          authorised_values.authorised_value, 
          authorised_values.lib, 
          authorised_values.lib_opac 
        From authorised_values 
        Where authorised_values.category = 'CCODE' 
      ) ccodess 
    Where branches.branchcode Like <<Choose your library|ZBRAN>> 
  ) branchesscodess 
  Join statistics On statistics.branch = branchesscodess.branchcode 
  And statistics.location = branchesscodess.LOCATION_CODE 
  And statistics.itemtype = branchesscodess.ITEM_TYPE_CODE 
  And statistics.ccode = branchesscodess.COLLECTION_CODE_CODE 
Where ( 
    statistics.type = 'issue' 
    Or statistics.type = 'renew' 
  ) 
  And statistics.datetime Between <<The beginning of the day on date1|date>> And (<<the end of the day on date2|date>> + Interval 1 Day) 
Group By  
  branchesscodess.branchname, 
  branchesscodess.branchcode, 
  branchesscodess.LOCATION, 
  branchesscodess.LOCATION_CODE, 
  branchesscodess.ITEM_TYPE, 
  branchesscodess.ITEM_TYPE_CODE, 
  branchesscodess.COLLECTION_CODE_DESCRIPTION, 
  branchesscodess.COLLECTION_CODE_CODE, 
  statistics.type 
Order By  
  branchesscodess.branchname, 
  branchesscodess.branchcode, 
  branchesscodess.LOCATION, 
  branchesscodess.LOCATION_CODE, 
  branchesscodess.ITEM_TYPE, 
  branchesscodess.ITEM_TYPE_CODE, 
  branchesscodess.COLLECTION_CODE_DESCRIPTION, 
  branchesscodess.COLLECTION_CODE_CODE 

























