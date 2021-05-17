/*
R.003322

----------

Name: GHW - Total late fees collected at a library - by month
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-04-30 15:39:17
Modified on: 2020-12-30 11:07:30
Date last run: 2021-05-03 12:25:38

----------

Public: 0
Expiry: 300

----------

No data prior to August of 2018

----------
*/

SELECT
  borrowers.branchcode,
  Year(account_offsets.created_on),
  Month(account_offsets.created_on),
  Format(Sum(ABS(account_offsets.amount)), 2) AS Sum_amount,
  accountlines1.debit_type_code,
  account_offsets.type
FROM
  account_offsets JOIN
  accountlines ON accountlines.accountlines_id = account_offsets.credit_id JOIN
  borrowers ON accountlines.manager_id = borrowers.borrowernumber JOIN
  accountlines accountlines1 ON accountlines1.accountlines_id =
      account_offsets.debit_id
WHERE
  accountlines1.debit_type_code = 'OVERDUE' AND
  account_offsets.type = 'Payment' AND
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  borrowers.branchcode,
  Year(account_offsets.created_on),
  Month(account_offsets.created_on),
  accountlines1.debit_type_code,
  account_offsets.type
ORDER BY
  borrowers.branchcode,
  Year(account_offsets.created_on),
  Month(account_offsets.created_on)



