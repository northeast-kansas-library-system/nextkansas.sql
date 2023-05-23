/*
R.003687

----------

Name: GHW - Holds queue count for jQuery enhancement
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-11 21:57:00
Modified on: 2023-02-25 00:00:22
Date last run: 2023-05-23 14:04:51

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
  <p>Creates the holds queue button on the home page in the staff client</p>
  <ul>
    <li>Creates button to take staff to the current holds queue</li>
    <li>for the library you're logged in at</li>
    <li>grouped by holds queue branchcode</li>
    <li>button links to report 3084</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Relies on jQuery to work properly</p>
  <p></p>
  <p class= "notetags" style="display: none;">#jquery_enhancement</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



Select
  CONCAT(
    '<a class="btn btn-lg btn-info btn-block noprint" ',
    'style="font-size: 1.75em; color: white;" ',
    'href="/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3084&sql_params=',
    branches.branchcode,
    '&param_name=Choose+your+library|ZBRAN&limit=500" ',
    'target="_blank"> ',
    '<i class="fa fa-tasks"></i> Holds queue <br /><span style="font-weight: bold;">(',
    Count(Distinct request_counts.itemnumber),
    '</span> items)</a>'
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
    branches.branchcode = <<Enter branchcode>>
Group By
    branches.branchcode

























