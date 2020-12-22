/*
R.002888

----------

Name: GHW - Patrons with specified category
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-01-24 16:21:30
Modified on: 2017-01-24 16:21:30
Date last run: 2020-12-17 22:59:59

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.dateexpiry
FROM
  borrowers
WHERE
  borrowers.categorycode LIKE <<Borrower's category|categorycode>> AND
  borrowers.branchcode LIKE <<Borrower's home library|ZBRAN>>
GROUP BY
  borrowers.branchcode, borrowers.categorycode, borrowers.cardnumber,
  borrowers.surname, borrowers.dateexpiry
ORDER BY
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.surname



