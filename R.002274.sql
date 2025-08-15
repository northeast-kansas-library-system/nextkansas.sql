/*
R.002274

----------

Name: Data in the borrowers table that needs to be deleted
Created by: Heather Braum

----------

Group: Administrative Reports
     Patrons-admin

Created on: 2014-06-05 15:14:42
Modified on: 2019-02-10 21:11:55
Date last run: 2025-04-28 21:57:16

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  Concat('edit patron') AS EDIT_PATRON,
  borrowers.branchcode,
  borrowers.contactnote,
  borrowers.borrowernotes
FROM
  borrowers
WHERE
  (borrowers.contactnote REGEXP '[0-9]{3}\-?[0-9]{2}\-?[0-9]{4}' OR
    borrowers.borrowernotes REGEXP '[0-9]{3} ?\-? ?[0-9]{2} ?\-? ?[0-9]{4}')
ORDER BY
  borrowers.branchcode

























