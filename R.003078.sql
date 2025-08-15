/*
R.003078

----------

Name: GHW - List of patrons
Created by: George Williams

----------

Group: Borrowers
     -

Created on: 2018-05-01 22:22:47
Modified on: 2024-01-17 11:58:16
Date last run: 2025-07-25 11:14:22

----------

Public: 0
Expiry: 300

----------

 
Generates a list of patrons with basic contact information
Lists all un-deleted patrons - active and expired
at the library you specify
grouped by borrowernumber
sorted by surname, first name, and date of birth
contains links to the patron record

Notes:

Click here to run in a new window


----------
*/



SELECT
  borrowers.cardnumber,
  Concat(borrowers.surname, ", ", borrowers.firstname, If(borrowers.othernames = "", "", Concat(" (", borrowers.othernames, ")"))) AS NAME,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.email,
  borrowers.phone,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateofbirth,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  Concat('Link to patron') AS LINK_TO_PATRON
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode LIKE &lt;&gt;
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.dateofbirth

























