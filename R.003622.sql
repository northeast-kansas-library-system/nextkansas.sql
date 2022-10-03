/*
R.003622

----------

Name: GHW - Pending checkout notes
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-11-09 00:57:48
Modified on: 2021-11-09 01:35:49
Date last run: 2022-10-03 13:42:21

----------

Public: 0
Expiry: 30

----------



----------
*/



SELECT
  "hidden" AS class,
  CONCAT(
    '<a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3623&phase=Run+this+report&param_name=Enter+branchcode&sql_params=',
    issues.branchcode,
    '" target="_blank">Notes for ', 
    issues.branchcode,
    '</a>'
  ) AS link
FROM
  issues
WHERE
  issues.branchcode LIKE <<Enter branchcode>> AND
  issues.note <> '' AND
  issues.noteseen = 0
GROUP BY
  issues.branchcode

























