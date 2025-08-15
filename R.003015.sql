/*
R.003015

----------

Name: GHW - Hold Contact Method
Created by: George Williams

----------

Group: Borrowers
     -

Created on: 2017-12-08 18:58:23
Modified on: 2024-01-17 11:52:09
Date last run: 2020-04-30 14:34:26

----------

Public: 0
Expiry: 300

----------

 
Generates a list of patrons based on their holds contact method
Shows current data only
for patrons at the library you specify
grouped by card number
sorted by homebranch and name

Notes:

Click here to run in a new window


----------
*/



SELECT
  borrowers.branchcode,
  borrowers.cardnumber,
  Concat(borrowers.surname, ", ", borrowers.firstname) AS BORROWER_NAME,
  Coalesce(Concat(hold.code, ", ", hold.lib), "-") AS METHOD,
  IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Book%", "Book club", IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Email%", IF(borrowers.email = "", "---", borrowers.email), IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Home%", "Home delivery", IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Post%", "Postcard", IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Phone%", IF(borrowers.phone = "", "---", borrowers.phone), IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Text%", IF(borrowers.smsalertnumber &lt; 1, "---", IF(borrowers.smsalertnumber IS NULL, "---", borrowers.smsalertnumber)), "-")))))) AS CONTACT_AT
FROM
  borrowers
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        borrower_attributes.code,
        authorised_values.lib,
        authorised_values.authorised_value
      FROM
        borrower_attributes
        JOIN borrower_attribute_types ON borrower_attributes.code = borrower_attribute_types.code
        JOIN authorised_values ON borrower_attribute_types.authorised_value_category = authorised_values.category
          AND borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'HOLD') hold ON borrowers.borrowernumber = hold.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  Coalesce(hold.authorised_value, '-') LIKE &lt;&gt;
GROUP BY
  borrowers.cardnumber
ORDER BY
  borrowers.branchcode,
  BORROWER_NAME

























