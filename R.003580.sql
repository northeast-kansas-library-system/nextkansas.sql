/*
R.003580

----------

Name: LibraryIQ - Basic circulation rules (setup)
Created by: George H Williams

----------

Group: LibraryIQ
     Setup

Created on: 2021-10-11 11:06:21
Modified on: 2021-10-13 11:10:55
Date last run: 2021-10-29 17:21:52

----------

Public: 0
Expiry: 300

----------

#libraryiq #setup

----------
*/



SELECT
  circulation_rules.branchcode,
  Coalesce(categories.description, "All borrowers not specified above") AS
  BORROWER_CATEGORY,
  Coalesce(itemtypes.description, "All item types not specified above") AS
  ITEM_TYPE,
  circulation_rules.rule_value AS `Loan period`,
  CurDate() AS `Report Date`
FROM
  circulation_rules LEFT JOIN
  categories ON circulation_rules.categorycode = categories.categorycode
  LEFT JOIN
  itemtypes ON circulation_rules.itemtype = itemtypes.itemtype
WHERE
  circulation_rules.branchcode = <<Choose your library|branches>> AND
  circulation_rules.rule_name = 'issuelength'
ORDER BY
  circulation_rules.branchcode,
  Coalesce(categories.description, "Z"),
  Coalesce(itemtypes.description, "Z")

























