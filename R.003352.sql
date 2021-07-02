/*
R.003352

----------

Name: GHW - Quick maxissueqty report
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-09-08 00:05:01
Modified on: 2020-09-08 00:05:01
Date last run: 2021-05-24 22:02:16

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT 
  circulation_rules.id, 
  circulation_rules.branchcode, 
  circulation_rules.categorycode, 
  circulation_rules.itemtype, 
  circulation_rules.rule_name, 
  circulation_rules.rule_value 
FROM circulation_rules 
WHERE circulation_rules.rule_name = "maxissueqty" AND 
  circulation_rules.categorycode IS NULL AND 
  circulation_rules.itemtype IS NULL AND 
  circulation_rules.rule_value > 0 
ORDER BY 
  circulation_rules.rule_value 
  DESC



