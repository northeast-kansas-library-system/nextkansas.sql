/*
R.003770

----------

Name: GHW - Monthly system wide statistics - Biblios added count by item type at all Next libraries 
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-15 20:34:55
Modified on: 2024-01-17 11:17:25
Date last run: 2023-10-16 17:07:33

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
 
  &lt;div class="reportInfoContent"&gt; 
 
    &lt;p&gt;Counts bibliographic records&lt;/p&gt; 
 
    &lt;ul&gt; 
      &lt;li&gt;added in the previous calendar month&lt;/li&gt; 
      &lt;li&gt;at all Next Search Catalog libraries&lt;/li&gt; 
      &lt;li&gt;grouped and sorted by library where the bibliographic record was created and the current bibliographic level item type&lt;/li&gt; 
      &lt;li&gt;links&lt;/li&gt; 
    &lt;/ul&gt; 
 
  &lt;/div&gt; 
 
  &lt;div class="reportInfoNotes"&gt; 
 
    &lt;p&gt; 
      This report reflects the bibliographic shelving location, the bibliographic item type, and the bibliographic collection code at the time that the report was run.
    &lt;/p&gt; 

    &lt;p&gt; 
      If a bibliographic record does not have an item type in the 942$e, that record will be counted as having an "(Unclassified)" item type.
    &lt;/p&gt;

    &lt;p&gt; 
      If a bibliographic record does not have a shelving location in the 942$c, the count for that bibliographic record will appear in the "OTHER_OR_ALREADY_DELETED" column.
    &lt;/p&gt;

    &lt;p&gt; 
      If a bibliographic record was added in the previous calendar month but has been deleted by the time the report is run, the count for that bibliographic record will appear in the "OTHER_OR_ALREADY_DELETED" column.
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoLinks"&gt; 
 
    &lt;p id="sql_quick_down"&gt; 
      &lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3770"&gt; 
        Click here to download as a csv file 
      &lt;/a&gt; 
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoTags"&gt; 
 
    &lt;p style="display: none;"&gt; 
      #statistics 
      #monthly statistics 
      #next statistics 
      #biblio count 
      #count by item type
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
 
&lt;/div&gt; 

----------
*/



Select 
  branches_itypes.branchname,
  branches_itypes.description As ITEM_TYPE,
  Sum(total_biblios.Count_action_id) As TOTAL,
  Sum(adult_biblios.Count_action_id) As ADULT,
  Sum(young_adult_biblios.Count_action_id) As YOUNG_ADULT,
  Sum(juvenile_biblios.Count_action_id) As JUVENILE,
  Sum(other_biblios.Count_action_id) As OTHER_OR_ALREADY_DELETED
From (
    Select branches.branchname,
      branches.branchcode,
      itemtypes.itemtype,
      itemtypes.description
    From branches,
      itemtypes
  ) branches_itypes
  Left Join (
    Select borrowers.branchcode,
      Coalesce(biblioitems.itemtype, 'PUNC') As itemtype,
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
      Coalesce(biblioitems.itemtype, 'PUNC')
  ) total_biblios 
    On total_biblios.branchcode = branches_itypes.branchcode
    And total_biblios.itemtype = branches_itypes.itemtype
  Left Join (
    Select borrowers.branchcode,
      biblioitems.agerestriction,
      Coalesce(biblioitems.itemtype, 'PUNC') As itemtype,
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
      Coalesce(biblioitems.itemtype, 'PUNC')
  ) adult_biblios 
    On adult_biblios.branchcode = branches_itypes.branchcode
    And adult_biblios.itemtype = branches_itypes.itemtype
  Left Join (
    Select borrowers.branchcode,
      biblioitems.agerestriction,
      Coalesce(biblioitems.itemtype, 'PUNC') As itemtype,
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
      Coalesce(biblioitems.itemtype, 'PUNC')
  ) young_adult_biblios 
    On young_adult_biblios.branchcode = branches_itypes.branchcode
    And young_adult_biblios.itemtype = branches_itypes.itemtype
  Left Join (
    Select borrowers.branchcode,
      biblioitems.agerestriction,
      Coalesce(biblioitems.itemtype, 'PUNC') As itemtype,
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
      Coalesce(biblioitems.itemtype, 'PUNC')
  ) juvenile_biblios 
    On juvenile_biblios.branchcode = branches_itypes.branchcode
    And juvenile_biblios.itemtype = branches_itypes.itemtype
  Left Join (
    Select borrowers.branchcode,
      biblioitems.agerestriction,
      Coalesce(biblioitems.itemtype, 'PUNC') As itemtype,
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
      Coalesce(biblioitems.itemtype, 'PUNC')
  ) other_biblios 
    On other_biblios.branchcode = branches_itypes.branchcode
    And other_biblios.itemtype = branches_itypes.itemtype
Group By 
  branches_itypes.branchname,
  branches_itypes.description
Order By 
  branches_itypes.branchname,
  ITEM_TYPE

























