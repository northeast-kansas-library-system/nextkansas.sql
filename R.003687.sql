/*
R.003687

----------

Name: GHW - Holds queue count
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-11 21:57:00
Modified on: 2022-12-13 16:42:05
Date last run: 2022-12-14 13:49:11

----------

Public: 0
Expiry: 60

----------



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

























