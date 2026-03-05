/*
R.003700

----------

Name: GHW - Statistics - Local use by library and collection code
Created by: George Williams

----------

Group: Statistics
     -

Created on: 2023-02-01 12:28:31
Modified on: 2024-03-01 16:34:25
Date last run: 2024-12-05 10:01:53

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
      #ccode
      #previous_month 
    &lt;/p&gt; 
 
  &lt;/div&gt; 

  &lt;!-- html notes rendered on guided_reports.pl by jquery see https://wiki.koha-community.org/wiki/Query_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;

----------
*/



Select
    branchccodes.branchname As LIBRARY,
    branchccodes.lib As COLLECTION_CODE,
    Coalesce(Sum(all_lm.CKO_RENEW), "0") As LOCAL_USE_COUNT
From
    (Select
          branches.branchcode,
          authorised_values.authorised_value,
          authorised_values.lib,
          branches.branchname
      From
          branches,
          authorised_values
      Where
          authorised_values.category = 'CCODE' And
          branches.branchcode Like &lt;&gt;
      Order By
          branches.branchcode,
          authorised_values.lib) branchccodes Left Join
    (Select
          If(statistics.branch Is Null, "NEKLS", statistics.branch) As branch,
          If(statistics.ccode Is Null, "XXX", statistics.ccode) As CCODE,
          Count(&ast;) As CKO_RENEW
      From
          statistics
      Where
          Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
          Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
          statistics.type = 'localuse'
      Group By
          If(statistics.branch Is Null, "NEKLS", statistics.branch),
          If(statistics.ccode Is Null, "XXX", statistics.ccode)) all_lm On all_lm.branch = branchccodes.branchcode And
            all_lm.CCODE = branchccodes.authorised_value
Group By
    branchccodes.branchname,
    branchccodes.lib
Order By
    LIBRARY,
    COLLECTION_CODE

























