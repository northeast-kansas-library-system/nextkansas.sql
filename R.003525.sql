/*
R.003525

----------

Name: GHW - Borrower category update
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-06-15 23:51:19
Modified on: 2021-06-16 00:09:41
Date last run: 2021-07-15 20:35:50

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.dateofbirth,
  borrowers.branchcode,
  borrowers.categorycode,
  Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-') AS AGE
FROM
  borrowers
WHERE
  borrowers.branchcode = 'SILVERLAKE' AND
  borrowers.categorycode LIKE 'CHILD' AND
  Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-') < 18
GROUP BY
  borrowers.surname,
  borrowers.firstname,
  borrowers.dateofbirth,
  borrowers.branchcode,
  borrowers.categorycode,
  Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-')



