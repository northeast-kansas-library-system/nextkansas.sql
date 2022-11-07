/*
R.003620

----------

Name: GHW - Pending suggestion alerts
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-11-09 00:16:43
Modified on: 2021-11-09 00:42:00
Date last run: 2022-11-07 09:37:06

----------

Public: 0
Expiry: 30

----------



----------
*/



SELECT
  "hidden" AS class
FROM
  suggestions
WHERE
  suggestions.branchcode LIKE <<Enter branchcode>> AND
  suggestions.STATUS = 'asked'
GROUP BY
  suggestions.branchcode

























