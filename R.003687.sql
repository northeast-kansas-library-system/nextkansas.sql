/*
R.003687

----------

Name: GHW - Holds queue count for jQuery enhancement
Created by: George Williams

----------

Group: -
     -

Created on: 2022-12-11 21:57:00
Modified on: 2024-01-17 11:29:54
Date last run: 2023-09-12 15:57:27

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
  &lt;p&gt;Creates the holds queue button on the home page in the staff client&lt;/p&gt;
  &lt;ul&gt;
    &lt;li&gt;Creates button to take staff to the current holds queue&lt;/li&gt;
    &lt;li&gt;for the library you're logged in at&lt;/li&gt;
    &lt;li&gt;grouped by holds queue branchcode&lt;/li&gt;
    &lt;li&gt;button links to report 3084&lt;/li&gt;
  &lt;/ul&gt;&lt;br /&gt;
  &lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p&gt;Relies on jQuery to work properly&lt;/p&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p class= "notetags" style="display: none;"&gt;#jquery_enhancement&lt;/p&gt;
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;
&lt;/div&gt;

----------
*/



Select
  CONCAT(
    ' ',
    ' Holds queue (',
    Count(Distinct request_counts.itemnumber),
    ' items)'
  ) As COUNT
From
  branches Left Join
  (
    Select
      hold_fill_targets.source_branchcode,
      hold_fill_targets.itemnumber
    From
      hold_fill_targets
    Group By
      hold_fill_targets.source_branchcode,
      hold_fill_targets.itemnumber
  ) request_counts On request_counts.source_branchcode = branches.branchcode
Where
    branches.branchcode = &lt;&gt;
Group By
    branches.branchcode

























