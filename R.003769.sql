/*
R.003769

----------

Name: GHW - Monthly system wide statistics - Biblios added count by collection code at all Next libraries
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-15 17:28:23
Modified on: 2024-01-17 11:17:33
Date last run: 2023-10-16 16:34:54

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
 
  <div class="reportInfoContent"> 
 
    <p>Counts bibliographic records</p> 
 
    <ul> 
      <li>added in the previous calendar month</li> 
      <li>at all Next Search Catalog libraries</li> 
      <li>grouped and sorted by library where the bibliographic record was created and the current bibliographic level collection code</li> 
      <li>links</li> 
    </ul> 
 
  </div> 
 
  <div class="reportInfoNotes"> 
 
    <p> 
      This report reflects the bibliographic shelving location, the bibliographic item type, and the bibliographic collection code at the time that the report was run.
    </p> 

    <p> 
      If a bibliographic record does not have a collection code in the 942$e, that record will be counted as having an "(Unclassified)" collection code.
    </p>

    <p> 
      If a bibliographic record does not have a shelving location in the 942$c, the count for that bibliographic record will appear in the "OTHER_OR_ALREADY_DELETED" column.
    </p>

    <p> 
      If a bibliographic record was added in the previous calendar month but has been deleted by the time the report is run, the count for that bibliographic record will appear in the "OTHER_OR_ALREADY_DELETED" column.
    </p> 
 
  </div> 
 
  <div id="reportInfoLinks"> 
 
    <p id="sql_quick_down"> 
      <a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3769"> 
        Click here to download as a csv file 
      </a> 
    </p> 
 
  </div> 
 
  <div id="reportInfoTags"> 
 
    <p style="display: none;"> 
      #statistics 
      #monthly statistics 
      #next statistics 
      #biblio count 
    </p> 
 
  </div> 
 
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
 
</div> 

----------
*/



Select 
  branches_ccodes.branchname, 
  branches_ccodes.lib As COLLECTION_CODE, 
  Sum(total_biblios.Count_action_id) As TOTAL, 
  Sum(adult_biblios.Count_action_id) As ADULT, 
  Sum(young_adult_biblios.Count_action_id) As YOUNG_ADULT, 
  Sum(juvenile_biblios.Count_action_id) As JUVENILE, 
  Sum(other_bblios.Count_action_id) As OTHER_OR_ALREADY_DELETED 
From ( 
    Select branches.branchname, 
      branches.branchcode, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    From branches, 
      authorised_values 
    Where authorised_values.category = 'CCODE' 
  ) branches_ccodes 
  Left Join ( 
    Select borrowers.branchcode, 
      Coalesce(biblioitems.cn_class, 'XXX') As cn_class, 
      Count(Distinct action_logs.action_id) As Count_action_id 
    From action_logs 
      Left Join biblio On biblio.biblionumber = action_logs.object 
      Left Join biblioitems On biblioitems.biblionumber = biblio.biblionumber 
      Left Join borrowers On borrowers.borrowernumber = action_logs.user 
    Where Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) 
      And Month(action_logs.timestamp) = Month(Now() - Interval 1 Month) 
      And action_logs.module = 'CATALOGUING' 
      And action_logs.action = 'ADD' 
      And action_logs.info = 'biblio' 
    Group By borrowers.branchcode, 
      Coalesce(biblioitems.cn_class, 'XXX') 
  ) total_biblios 
    On total_biblios.branchcode = branches_ccodes.branchcode 
    And total_biblios.cn_class = branches_ccodes.authorised_value 
  Left Join ( 
    Select borrowers.branchcode, 
      biblioitems.agerestriction, 
      Coalesce(biblioitems.cn_class, 'XXX') As cn_class, 
      Count(Distinct action_logs.action_id) As Count_action_id 
    From action_logs 
      Left Join biblio On biblio.biblionumber = action_logs.object 
      Left Join biblioitems On biblioitems.biblionumber = biblio.biblionumber 
      Left Join borrowers On borrowers.borrowernumber = action_logs.user 
    Where Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) 
      And Month(action_logs.timestamp) = Month(Now() - Interval 1 Month) 
      And action_logs.module = 'CATALOGUING' 
      And action_logs.action = 'ADD' 
      And action_logs.info = 'biblio' 
      And biblioitems.agerestriction Like '%AD%' 
    Group By borrowers.branchcode, 
      biblioitems.agerestriction, 
      Coalesce(biblioitems.cn_class, 'XXX') 
  ) adult_biblios 
    On adult_biblios.branchcode = branches_ccodes.branchcode 
    And adult_biblios.cn_class = branches_ccodes.authorised_value 
  Left Join ( 
    Select borrowers.branchcode, 
      biblioitems.agerestriction, 
      Coalesce(biblioitems.cn_class, 'XXX') As cn_class, 
      Count(Distinct action_logs.action_id) As Count_action_id 
    From action_logs 
      Left Join biblio On biblio.biblionumber = action_logs.object 
      Left Join biblioitems On biblioitems.biblionumber = biblio.biblionumber 
      Left Join borrowers On borrowers.borrowernumber = action_logs.user 
    Where Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) 
      And Month(action_logs.timestamp) = Month(Now() - Interval 1 Month) 
      And action_logs.module = 'CATALOGUING' 
      And action_logs.action = 'ADD' 
      And action_logs.info = 'biblio' 
      And biblioitems.agerestriction Like '%YA%' 
    Group By borrowers.branchcode, 
      biblioitems.agerestriction, 
      Coalesce(biblioitems.cn_class, 'XXX') 
  ) young_adult_biblios 
    On young_adult_biblios.branchcode = branches_ccodes.branchcode 
    And young_adult_biblios.cn_class = branches_ccodes.authorised_value 
  Left Join ( 
    Select borrowers.branchcode, 
      biblioitems.agerestriction, 
      Coalesce(biblioitems.cn_class, 'XXX') As cn_class, 
      Count(Distinct action_logs.action_id) As Count_action_id 
    From action_logs 
      Left Join biblio On biblio.biblionumber = action_logs.object 
      Left Join biblioitems On biblioitems.biblionumber = biblio.biblionumber 
      Left Join borrowers On borrowers.borrowernumber = action_logs.user 
    Where Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) 
      And Month(action_logs.timestamp) = Month(Now() - Interval 1 Month) 
      And action_logs.module = 'CATALOGUING' 
      And action_logs.action = 'ADD' 
      And action_logs.info = 'biblio' 
      And biblioitems.agerestriction Like '%JU%' 
    Group By borrowers.branchcode, 
      biblioitems.agerestriction, 
      Coalesce(biblioitems.cn_class, 'XXX') 
  ) juvenile_biblios 
    On juvenile_biblios.branchcode = branches_ccodes.branchcode 
    And juvenile_biblios.cn_class = branches_ccodes.authorised_value 
  Left Join ( 
    Select borrowers.branchcode, 
      biblioitems.agerestriction, 
      Coalesce(biblioitems.cn_class, 'XXX') As cn_class, 
      Count(Distinct action_logs.action_id) As Count_action_id 
    From action_logs 
      Left Join biblio On biblio.biblionumber = action_logs.object 
      Left Join biblioitems On biblioitems.biblionumber = biblio.biblionumber 
      Left Join borrowers On borrowers.borrowernumber = action_logs.user 
    Where Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) 
      And Month(action_logs.timestamp) = Month(Now() - Interval 1 Month) 
      And action_logs.module = 'CATALOGUING' 
      And action_logs.action = 'ADD' 
      And action_logs.info = 'biblio' 
      And ( 
        biblioitems.agerestriction Is Null 
        Or biblioitems.agerestriction Like '' 
      ) 
    Group By borrowers.branchcode, 
      biblioitems.agerestriction, 
      Coalesce(biblioitems.cn_class, 'XXX') 
  ) other_bblios 
    On other_bblios.branchcode = branches_ccodes.branchcode 
    And other_bblios.cn_class = branches_ccodes.authorised_value 
Group By 
  branches_ccodes.branchname, 
  branches_ccodes.lib 
Order By 
  branches_ccodes.branchname, 
  branches_ccodes.lib 

























