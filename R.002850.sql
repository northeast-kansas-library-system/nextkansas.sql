/*
R.002850

----------

Name: GHW - Borrower Notes
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-12-09 17:43:52
Modified on: 2016-12-12 01:08:06
Date last run: 2021-05-17 10:42:55

----------

Public: 1
Expiry: 0

----------



----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.borrowernotes
FROM
  borrowers
WHERE
  borrowers.borrowernotes <> ' '

























