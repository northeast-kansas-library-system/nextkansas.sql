/*
R.003684

----------

Name: Holds queue reminder
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-02 16:23:49
Modified on: 2022-12-02 16:25:10
Date last run: 2022-12-02 16:25:23

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches.branchcode,
  Concat(
    'There are ', 
    Coalesce(queue_counts.Count_itemnumber, 0),
    ' items on the holds list', 
    '<br />', 
    '<a class="btn btn-default noprint"',
    'href="/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3084&sql_params=', 
    branches.branchcode, 
    '&param_name=Choose+your+library|ZBRAN&limit=1000"', 
    ' target="_blank">Print holds report</a>'
  ) AS INFO
FROM
  branches LEFT JOIN
  (SELECT
      hold_fill_targets.source_branchcode,
      Count(DISTINCT hold_fill_targets.itemnumber) AS Count_itemnumber
    FROM
      hold_fill_targets
    GROUP BY
      hold_fill_targets.source_branchcode) queue_counts ON
      queue_counts.source_branchcode = branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode

























