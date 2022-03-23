/*
R.003642

----------

Name: GHW - ADMINREPORT - GMD Cleanup
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-01-19 17:03:30
Modified on: 2022-01-19 20:24:59
Date last run: 2022-01-23 01:51:56

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Trim(Replace(Replace(Replace(Replace(Replace(biblio.medium, '/', ''), ':', ''), ';', ''), '.', ''), '=', '')) AS MEDIUM,
  Count(Distinct biblio.biblionumber) AS COUNT,
  CONCAT(
  '<a class="btn btn-default" href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=3643&phase=Run+this+report&param_name=Enter+search+term&sql_params=', 
  Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Trim(Replace(Replace(Replace(Replace(Replace(biblio.medium, '/', ''), ':', ''), ';', ''), '.', ''), '=', '')), ' ', '%20'), '[', '%5B'), ']', '%5D'), '{', '%7B'), '}', '7D'), '#', '%23'), '(', '%28'), ')', '%29'),
  '" target="_blank">Run report 3643</a>') AS LINK
FROM
  biblio
GROUP BY
  Trim(Replace(Replace(Replace(Replace(Replace(biblio.medium, '/', ''), ':', ''), ';', ''), '.', ''), '=', ''))

























