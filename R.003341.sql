/*
R.003341

----------

Name: GHW - Adults with guarantors
Created by: George Williams

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
  (borrowers.dateofbirth &lt;= CurDate() - INTERVAL 18 YEAR OR
      borrowers.dateofbirth IS NULL) AND
  (borrowers.relationship &lt;&gt; '' OR
      borrowers.contactname &lt;&gt; '' OR
      borrowers.contactfirstname &lt;&gt; '' OR
      borrower_relationships.guarantor_id &lt;&gt; '')
GROUP BY
  borrower_relationships.guarantor_id,
  borrowers.borrowernotes,
  borrowers.dateofbirth,
  borrowers.borrowernumber

























