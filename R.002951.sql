/*
R.002951

----------

Name: GHW - Patrons with Newsletter permission flag during date range
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-05-30 10:34:44
Modified on: 2017-05-30 10:35:32
Date last run: 2022-10-31 11:10:58

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.branchcode,
  borrowers.cardnumber,
  Concat(borrowers.surname, ", ", borrowers.firstname) AS BORROWER_NAME,
  borrowers.email,
  Concat(newsletter.code, ", ", newsletter.lib) AS PERMISSION
FROM
  borrowers LEFT JOIN
  (SELECT
    borrower_attributes.borrowernumber,
    borrower_attributes.code,
    authorised_values.lib,
    authorised_values.authorised_value
  FROM
    borrower_attributes INNER JOIN
    borrower_attribute_types
      ON borrower_attributes.code = borrower_attribute_types.code INNER JOIN
    authorised_values
      ON borrower_attribute_types.authorised_value_category =
      authorised_values.category AND borrower_attributes.attribute =
      authorised_values.authorised_value
  WHERE
    borrower_attributes.code = 'NEWSLETTER') newsletter
    ON borrowers.borrowernumber = newsletter.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose patron home branch|ZBRAN>> AND
  Coalesce(newsletter.authorised_value, 'NotAsked') LIKE <<Newsletter Permission|YEMAILNEWS>> AND
  borrowers.dateenrolled BETWEEN <<Patron account created between|date>> and (<<and|date>> + interval 1 day) 
GROUP BY
  borrowers.cardnumber, borrowers.email
ORDER BY
  borrowers.branchcode, Concat(borrowers.surname, ", ", borrowers.firstname)

























