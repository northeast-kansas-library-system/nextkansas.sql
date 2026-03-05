/*
R.003689

----------

Name: GHW - Quick count - Current holds queue count
Created by: George Williams

----------

Group: -
     -

Created on: 2022-12-12 21:46:37
Modified on: 2023-10-16 21:59:30
Date last run: 2023-08-26 23:15:44

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
  &lt;p&gt;Gives a count for the requests queue at all Next Search Catalog libraries&lt;/p&gt;
  &lt;ul&gt;
    &lt;li&gt;Shows counts for current holds queue&lt;/li&gt;
    &lt;li&gt;at all Next libraries&lt;/li&gt;
    &lt;li&gt;grouped and sorted by library with a total at the top of the column&lt;/li&gt;
  &lt;/ul&gt;&lt;br /&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p class= "notetags" style="display: none;"&gt;#quick_count&lt;/p&gt;
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;
&lt;/div&gt;

----------
*/



Select
  branches.branchcode AS LIBRARY,
  Coalesce(targets.COUNT, 0) As COUNT
From
  branches Left Join
  (
    Select
      hold_fill_targets.source_branchcode,
        Count(Distinct hold_fill_targets.itemnumber) As COUNT
      From
        hold_fill_targets
      Group By
        hold_fill_targets.source_branchcode
  ) targets On targets.source_branchcode = branches.branchcode
Group By
  branches.branchcode,
  Coalesce(targets.COUNT, 0)
Union
Select
  Concat(' Total') AS LIBRARY,
  Count(Distinct hold_fill_targets.itemnumber) As COUNT_TOTAL
From
  hold_fill_targets
Order By
  LIBRARY
LIMIT 100

























