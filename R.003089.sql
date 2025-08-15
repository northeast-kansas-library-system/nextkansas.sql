/*
R.003089

----------

Name: GHW - Patron attributes - Special locations
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2018-06-29 08:33:47
Modified on: 2024-01-17 11:58:09
Date last run: 2023-09-07 16:57:38

----------

Public: 0
Expiry: 300

----------

 
Generates a list of patrons with contact information based on their "Special location" attributes
Shows current patrons
with the home library and special location you specify
grouped by borrower number and attribute
sorted by patron last name/patron first name
contains links to the patron's account

Notes:

This report can be used to determine which patrons at your library have a special location attribute set on their account.

Click here to run in a new window


----------
*/



SELECT
  Concat("Patron") AS LINK_TO_PATRON,
  borrowers.cardnumber,
  Concat_Ws("", If(borrowers.surname = "", "-", borrowers.surname), " / ", If(borrowers.firstname = "", "-", borrowers.firstname), If(borrowers.othernames = "", " ", Concat(" - (", borrowers.othernames, ")"))) AS NAME,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.email,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateofbirth,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  Coalesce(location.lib, "~") AS SPECIAL_LOCATION
FROM
  borrowers
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute
      FROM
        borrower_attributes
        JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'Location' AND
        authorised_values.category = 'SPECLOC'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute,
        borrower_attributes.code) location ON borrowers.borrowernumber = location.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode LIKE &lt;&gt; AND
  Coalesce(location.attribute, "~") LIKE &lt;&gt;
GROUP BY
  borrowers.email,
  borrowers.dateofbirth,
  borrowers.borrowernumber,
  borrowers.othernames
ORDER BY
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname

























