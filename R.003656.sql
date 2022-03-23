/*
R.003656

----------

Name: GHW - Internet permission killer
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-03-08 16:16:13
Modified on: 2022-03-08 16:16:13
Date last run: 2022-03-08 16:19:45

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.cardnumber,
  borrower_attributes.borrowernumber,
  borrowers.branchcode,
  authorised_values.lib
FROM
  borrower_attributes JOIN
  authorised_values ON borrower_attributes.attribute =
      authorised_values.authorised_value INNER JOIN
  borrowers ON borrower_attributes.borrowernumber = borrowers.borrowernumber
WHERE
  borrower_attributes.code = 'INTERNET' AND
  authorised_values.category = 'InternetPolicy' AND
  borrowers.branchcode Like <<Choose your library|ZBRAN>>
GROUP BY
  borrower_attributes.borrowernumber,
  borrowers.branchcode,
  authorised_values.lib

























