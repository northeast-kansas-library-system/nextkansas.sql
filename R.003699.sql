/*
R.003699

----------

Name: GHW - Statistics - Local use by library and item type
Created by: George Williams

----------

Group: Statistics
     -

Created on: 2023-02-01 10:38:58
Modified on: 2024-03-01 16:34:46
Date last run: 2024-12-10 16:37:46

----------

Public: 0
Expiry: 300

----------

&lt;div id="reportinfo" class="reportInfo noprint"&gt;
 
  &lt;div class="reportInfoContent"&gt; 
 
    &lt;p&gt;Counts "localuse" checkouts by item type&lt;/p&gt; 
 
    &lt;ul&gt; 
      &lt;li&gt;during the previous calendar month&lt;/li&gt; 
      &lt;li&gt;at the library you specify&lt;/li&gt; 
      &lt;li&gt;grouped and sorted by library and item type&lt;/li&gt; 
    &lt;/ul&gt; 
 
  &lt;/div&gt; 
 
  &lt;div class="reportInfoNotes"&gt; 

    &lt;p&gt;&lt;/p&gt;
    &lt;p&gt;Collecting local use data requires the use of a "Staff - statistical purposes" library card.&lt;/p&gt;
    &lt;p&gt;&lt;/p&gt;
 
  &lt;/div&gt; 
 

  &lt;div id="reportInfoTags"&gt; 
 
    &lt;p style="display: none;"&gt; 
      #localuse
      #statistics
      #itype
      #previous_month 
    &lt;/p&gt; 
 
  &lt;/div&gt; 

  &lt;!-- html notes rendered on guided_reports.pl by jquery see https://wiki.koha-community.org/wiki/Query_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;

----------
*/



Select
    branch_itype.branchname AS LIBRARY,
    branch_itype.description AS ITEM_TYPE,
    Coalesce(Sum(statistics_all.CKO_REN), 0) As LOCAL_USE_COUNT
From
    (Select
          branches.branchname,
          itemtypes.description,
          branches.branchcode,
          itemtypes.itemtype
      From
          branches,
          itemtypes
      Where
          branches.branchcode Like &lt;&gt;) branch_itype Left Join
    (Select
          Coalesce(statistics.branch, "NEKLS") As branch,
          Coalesce(statistics.itemtype, "BOOK") As itemtype,
          Count(&ast;) As CKO_REN
      From
          statistics
      Where
          statistics.type = 'localuse' And
          Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
          Month(statistics.datetime) = Month(Now() - Interval 1 Month)
      Group By
          Coalesce(statistics.branch, "NEKLS"),
          Coalesce(statistics.itemtype, "BOOK")
      Order By
          branch,
          itemtype) statistics_all On statistics_all.branch = branch_itype.branchcode And
            statistics_all.itemtype = branch_itype.itemtype
Group By
    branch_itype.branchname,
    branch_itype.description 
ORDER BY
    LIBRARY,
    ITEM_TYPE

























