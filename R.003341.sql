/*
R.003341

----------

Name: GHW - Adults with guarantors
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-07-27 14:46:13
Modified on: 2020-07-27 14:46:13
Date last run: 2022-03-31 10:39:29

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.contactname,
  borrowers.contactfirstname,
  borrowers.contacttitle,
  borrowers.relationship,
  borrower_relationships.guarantor_id,
  borrowers.borrowernotes,
  borrowers.dateofbirth
FROM
  borrowers LEFT JOIN
  borrower_relationships ON borrower_relationships.guarantee_id =
      borrowers.borrowernumber
WHERE
  (borrowers.dateofbirth <= CurDate() - INTERVAL 18 YEAR OR
      borrowers.dateofbirth IS NULL) AND
  (borrowers.relationship <> '' OR
      borrowers.contactname <> '' OR
      borrowers.contactfirstname <> '' OR
      borrower_relationships.guarantor_id <> '')
GROUP BY
  borrower_relationships.guarantor_id,
  borrowers.borrowernotes,
  borrowers.dateofbirth,
  borrowers.borrowernumber

























