/*
R.003086

----------

Name: GHW - Patron attributes - Newsletter permissions
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2018-06-28 18:09:20
Modified on: 2024-01-17 11:58:14
Date last run: 2025-08-01 15:20:12

----------

Public: 0
Expiry: 300

----------

 
Generates a list of patrons with contact information based on their "Newsletter permission" attributes
Shows current patrons
with the home library and newsletter permission you specify
grouped by borrower number and attribute
sorted by patron last name/patron first name
contains links to the patron's account

Notes:

Replaces report 2887 (GHW - Patrons with Newsletter permission flag).

This report can be used to determine which patrons at your library have agreed to let you use their e-mail address from the catalog for the purposes of sending them an e-mail newsletter.

Click here to run in a new window


----------
*/



SELECT
  Concat(
    "Patron"
  ) AS LINK_TO_PATRON,
  borrowers.cardnumber,
  If(
    Coalesce(newsletter_permission.lib, "~") = "YES", 
    Concat_Ws(
      "", 
      If(borrowers.surname = "", "-", borrowers.surname), 
      " / ", 
      If(borrowers.firstname = "", "-", borrowers.firstname), 
      If(borrowers.othernames = "", " ", Concat(" - (", borrowers.othernames, ")")
      )
    ), "Permission not given"
  ) AS NAME,
  If(
    Coalesce(newsletter_permission.lib, "~") = "YES", 
    Concat(borrowers.address, 
    "", 
    borrowers.address2, 
    "", 
    borrowers.city, 
    ", ",
    borrowers.state, 
    " ", 
    borrowers.zipcode), 
    "Permission not given"
  ) as ADDRESS,
  If(
    Coalesce(newsletter_permission.lib, "~") = "YES", 
    borrowers.email, 
    "Permission not given"
  ) AS email,
  borrowers.branchcode,
  borrowers.categorycode,
  If(
    Coalesce(newsletter_permission.lib, "~") = "YES", 
    borrowers.dateofbirth, 
    "Permission not given"
  ) AS dateofbirth,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  Coalesce(newsletter_permission.lib, "~") AS NEWSLETTER_PERMISSION
FROM
  borrowers LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      authorised_values.lib,
      borrower_attributes.attribute
    FROM
      borrower_attributes JOIN
      authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'NEWSLETTER' AND
      authorised_values.category = 'EmailNews'
    GROUP BY
      borrower_attributes.borrowernumber,
      borrower_attributes.attribute) newsletter_permission ON borrowers.borrowernumber = newsletter_permission.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode LIKE &lt;&gt; AND
  Coalesce(newsletter_permission.attribute, "~") LIKE &lt;&gt;
GROUP BY
  Coalesce(newsletter_permission.lib, "~"),
  If(borrowers.email LIKE "%", "X", "Y"),
  borrowers.borrowernumber
ORDER BY
  borrowers.surname,
  borrowers.firstname

























