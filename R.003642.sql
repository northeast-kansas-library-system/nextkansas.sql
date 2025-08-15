/*
R.003642

----------

Name: GHW - ADMINREPORT - GMD Cleanup
Created by: George Williams

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
  'Run report 3643') AS LINK
FROM
  biblio
GROUP BY
  Trim(Replace(Replace(Replace(Replace(Replace(biblio.medium, '/', ''), ':', ''), ';', ''), '.', ''), '=', ''))

























