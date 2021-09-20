/*
R.002966

----------

Name: GHW - Collection agency report 03 - Unique management
Created by: George H Williams

----------

Group:  OTTAWA
     -

Created on: 2017-06-27 17:08:37
Modified on: 2021-08-16 13:44:09
Date last run: 2021-09-17 11:05:41

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Shows patrons that OTTAWA has turned over to their collection agency</p>
<ul><li>Shows patrons who currently have collection agency flags on their account.</li>
<li>regardless of the patron's home library</li>
<li>grouped by borrowernumber and sort1</li>
<li>sorted by borrowers name, last name first</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2966&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  Format(Sum(accountlines.amountoutstanding), 2) AS Due
FROM
  accountlines
  LEFT JOIN borrowers ON accountlines.borrowernumber = borrowers.borrowernumber
  LEFT JOIN categories ON borrowers.categorycode = categories.categorycode
  LEFT JOIN (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      authorised_values.category,
      authorised_values.lib
    FROM
      borrower_attributes
      JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'CAOTTAWA' AND
      authorised_values.category = 'COLLAGEN') collagen ON borrowers.borrowernumber = collagen.borrowernumber
WHERE
  collagen.attribute LIKE "OTTA%"
GROUP BY
  borrowers.borrowernumber,
  borrowers.cardnumber
ORDER BY
  borrowers.surname,
  borrowers.firstname



