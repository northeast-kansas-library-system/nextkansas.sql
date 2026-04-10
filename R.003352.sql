/*
R.003352

----------

Name: GHW - Quick maxissueqty report
Created by: George Williams

----------

Group: Rules
     -

Created on: 2020-09-08 00:05:01
Modified on: 2026-03-27 14:06:32
Date last run: 2026-03-27 14:06:32

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

























