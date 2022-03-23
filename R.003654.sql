/*
R.003654

----------

Name: GHW - Movie permission killer
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-03-02 15:46:42
Modified on: 2022-03-02 16:15:09
Date last run: 2022-03-08 14:21:36

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
  borrower_attributes.code = 'MOVIE' AND
  authorised_values.category = 'FILMPERM' AND
  borrowers.branchcode Like <<Choose your library|ZBRAN>>
GROUP BY
  borrower_attributes.borrowernumber,
  borrowers.branchcode,
  authorised_values.lib

























