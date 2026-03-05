/*
R.003651

----------

Name: GHW - Links to edit circulation rules en masse
Created by: George Williams

----------

Group: -
     -

Created on: 2022-02-23 18:02:07
Modified on: 2022-02-23 18:02:41
Date last run: 2023-10-23 17:52:48

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    'https://staff.nextkansas.org/cgi-bin/koha/admin/smart-rules.pl?branch=', 
    branches.branchcode
  ) AS RULES_LINK
FROM
  branches
UNION
(SELECT
  Concat(
    'https://staff.nextkansas.org/cgi-bin/koha/admin/smart-rules.pl?branch=', 
    '*'
  ) AS RULES_LINK
FROM
  branches)
ORDER BY
  If(
    RULES_LINK LIKE "%DONI%", 
    Concat("Y", RULES_LINK), 
    If(
      RULES_LINK LIKE "%PH%", 
      Concat("Z", RULES_LINK), 
      RULES_LINK
    )
  ) DESC
LIMIT 100

























