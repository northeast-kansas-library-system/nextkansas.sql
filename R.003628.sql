/*
R.003628

----------

Name: Test replacement
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-12-17 09:54:22
Modified on: 2021-12-17 10:45:45
Date last run: 2022-11-07 17:26:37

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branchess.branchname,
  fees.date AS FEE_CREATED_ON,
  fees.credit_type_code,
  fees.debit_type_code,
  fees.accountlines_id,
  fees.issue_id,
  Format(fees.amountoutstanding, 2) AS AMOUNT_OUTSTANDING,
  fees.note,
  fees.timestamp FEE_UPDATED_ON
FROM
  (SELECT
      branches.branchname,
      branches.branchcode
    FROM
      branches
    UNION
    SELECT
      ' All branches' AS branchname,
      '--' AS branchcode) branchess JOIN
  (SELECT
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.borrowernumber,
      accountlines.date,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.note,
      accountlines.manager_id,
      Coalesce(Coalesce(issues.branchcode, old_issues.branchcode),
      '--') AS branchcode
    FROM
      accountlines LEFT JOIN
      issues ON issues.issue_id = accountlines.issue_id LEFT JOIN
      old_issues ON old_issues.issue_id = accountlines.issue_id
    WHERE
      accountlines.amountoutstanding > 0 AND
      accountlines.borrowernumber IS NOT NULL
    GROUP BY
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.note
    UNION
    SELECT
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.borrowernumber,
      accountlines.date,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.note,
      accountlines.manager_id,
      Coalesce(staff.branchcode, '--') AS branchcode
    FROM
      accountlines LEFT JOIN
      issues ON issues.issue_id = accountlines.issue_id LEFT JOIN
      old_issues ON old_issues.issue_id = accountlines.issue_id LEFT JOIN
      borrowers staff ON staff.borrowernumber = accountlines.manager_id
    WHERE
      accountlines.amountoutstanding > 0 AND
      accountlines.manager_id IS NOT NULL AND
      accountlines.borrowernumber IS NOT NULL
    GROUP BY
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.note
    UNION
    SELECT
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.borrowernumber,
      accountlines.date,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.note,
      accountlines.manager_id,
      Coalesce(borrowers.branchcode, '--') AS branchcode1
    FROM
      accountlines LEFT JOIN
      issues ON issues.issue_id = accountlines.issue_id LEFT JOIN
      old_issues ON old_issues.issue_id = accountlines.issue_id LEFT JOIN
      borrowers staff ON staff.borrowernumber = accountlines.manager_id
      LEFT JOIN
      borrowers ON borrowers.borrowernumber = accountlines.borrowernumber
    WHERE
      accountlines.amountoutstanding > 0 AND
      Coalesce(issues.branchcode, old_issues.branchcode) IS NULL AND
      staff.branchcode IS NULL AND
      accountlines.borrowernumber IS NOT NULL
    GROUP BY
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.note) fees ON fees.branchcode = branchess.branchcode
WHERE
  branchess.branchcode LIKE <<Choose your library|ZBRAN>> AND
  fees.debit_type_code LIKE <<Debit type|LDEBITTYPE>>
GROUP BY
  fees.accountlines_id
ORDER BY
  branchess.branchname

























