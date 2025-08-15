/*
R.003090

----------

Name: GHW - Patron attributes - Holds contact
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2018-06-29 08:54:23
Modified on: 2024-01-17 11:58:06
Date last run: 2023-08-17 16:38:42

----------

Public: 0
Expiry: 300

----------

 
Generates a list of patrons with contact information based on their "Hold contact" attributes
Shows current patrons
with the home library and hold contact method you specify
grouped by borrower number and attribute
sorted by patron last name/patron first name
contains links to the patron's account

Notes:

This report can be used to determine which patrons at your library have a hold contract attribute set.

Click here to run in a new window


----------
*/



SELECT
  Concat(
    "Patron"
  ) AS LINK_TO_PATRON,
  borrowers.cardnumber,
  Concat_Ws("", 
    If(
      borrowers.surname = "", 
      "-", 
      borrowers.surname
    ), 
    " / ", 
    If(
      borrowers.firstname = "", 
      "-", 
      borrowers.firstname
    ), 
    If(
      borrowers.othernames = "", 
      " ", 
      Concat(" - (", borrowers.othernames, ")")
    )
  ) AS NAME,
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
  Coalesce(holdscontact.lib, "~") AS HOLDS_CONTACT
FROM
  borrowers
  LEFT JOIN 
    (SELECT
      borrower_attributes.borrowernumber,
      authorised_values.lib,
      borrower_attributes.attribute
    FROM
      borrower_attributes
    JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'HOLD' AND
      authorised_values.category = 'HoldsContact'
    GROUP BY
      borrower_attributes.borrowernumber,
      borrower_attributes.attribute,
      borrower_attributes.code
    ) holdscontact 
  ON borrowers.borrowernumber = holdscontact.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode LIKE &lt;&gt; AND
  Coalesce(holdscontact.attribute, "~") LIKE &lt;&gt;
GROUP BY
  borrowers.borrowernumber,
  Coalesce(holdscontact.lib, "~")
ORDER BY
  borrowers.surname,
  borrowers.firstname

























