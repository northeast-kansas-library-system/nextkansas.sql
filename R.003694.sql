/*
R.003694

----------

Name: GHW - Holds queue count by library with links
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-01-03 09:19:30
Modified on: 2023-01-03 09:19:30
Date last run: 2023-02-13 12:21:48

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  hold_fill_targets.source_branchcode, 
  Count(DISTINCT hold_fill_targets.itemnumber) AS Count_itemnumber, 
  Concat_Ws('', 
    '<a ', 
    'class="btn btn-success noprint" ', 
    'style="color: white;" ', 
    'href=/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3084&sql_params=', 
    hold_fill_targets.source_branchcode, 
    '&param_name=Choose+your+library|ZBRAN&limit=500" target="_blank">List of items</a>' 
  ) AS QUEUE 
FROM 
  hold_fill_targets 
GROUP BY 
  hold_fill_targets.source_branchcode 

























