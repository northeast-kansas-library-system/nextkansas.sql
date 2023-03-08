/*
R.003518

----------

Name: GHW - CIrculation rules - Checkout and hold policy
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-06-10 14:33:05
Modified on: 2022-10-11 09:08:39
Date last run: 2023-02-15 11:02:47

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches_categoriess.branchname AS BRANCH,
  branches_categoriess.description AS CATEGORY,
  patron_maxissueqty.rule_value AS MAX_CKO,
  patron_maxonsiteissueqty.rule_value AS MAX_ONSITE,
  max_holds.rule_value AS MAX_REQUESTS,
  If(
    categories_branches.branchcode IS NOT NULL, 
    'Yes', 
    ''
  ) AS STAFF_CAN_CREATE_NEW_BORROWERS
FROM
  (
    SELECT
      branchess.branchcode,
      branchess.branchname,
      categoriess.categorycode,
      categoriess.description
    FROM
      (
        SELECT
          branches.branchcode,
          branches.branchname
        FROM
          branches
        UNION
        SELECT
          Concat('*') AS branchcode,
          Concat(' All libraries') AS branchname
        FROM
          branches
      ) branchess,
      (
        SELECT
          categories.categorycode,
          categories.description
        FROM
          categories
        UNION
        SELECT
          Concat('*') AS categorycode,
          Concat(' All borrower categories') AS description
        FROM
          categories
      ) categoriess
    WHERE
      (branchess.branchcode LIKE <<Choose your library|LBRANCH>> OR
      branchess.branchcode LIKE '*') AND
      (categoriess.categorycode LIKE <<Choose borrower category|LBORROWERCAT>> OR
      categoriess.categorycode LIKE '*')
  ) branches_categoriess LEFT JOIN
  (
    SELECT
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, '*') AS branchcode,
      Coalesce(circulation_rules.categorycode, '*') AS categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'patron_maxissueqty'
  ) patron_maxissueqty ON
      patron_maxissueqty.branchcode = branches_categoriess.branchcode AND
      patron_maxissueqty.categorycode = branches_categoriess.categorycode
  LEFT JOIN
  (
    SELECT
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, '*') AS branchcode,
      Coalesce(circulation_rules.categorycode, '*') AS categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'patron_maxonsiteissueqty'
  ) patron_maxonsiteissueqty ON 
      patron_maxonsiteissueqty.branchcode = branches_categoriess.branchcode AND
      patron_maxonsiteissueqty.categorycode = branches_categoriess.categorycode
  LEFT JOIN
  (
    SELECT
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, '*') AS branchcode,
      Coalesce(circulation_rules.categorycode, '*') AS categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'max_holds'
  ) max_holds ON
      max_holds.branchcode = branches_categoriess.branchcode AND
      max_holds.categorycode = branches_categoriess.categorycode LEFT JOIN
    categories_branches ON 
      categories_branches.branchcode = branches_categoriess.branchcode AND
      categories_branches.categorycode = branches_categoriess.categorycode
GROUP BY
  branches_categoriess.branchname,
  branches_categoriess.description
ORDER BY
  BRANCH,
  CATEGORY

























