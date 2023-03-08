/*
R.003689

----------

Name: GHW - Quick count - Current holds queue count
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-12 21:46:37
Modified on: 2022-12-14 15:40:29
Date last run: 2022-12-15 07:15:41

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
  <p>Gives a count for the requests queue at all Next Search Catalog libraries</p>
  <ul>
    <li>Shows counts for current holds queue</li>
    <li>at all Next libraries</li>
    <li>grouped and sorted by library with a total at the top of the column</li>
  </ul><br />
  <p></p>
  <p class= "notetags" style="display: none;">#quick_count</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

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

























