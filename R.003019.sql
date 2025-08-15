/*
R.003019

----------

Name: GHW - Users with failed password login attempts
Created by: George Williams

----------

Group: Borrowers
     Fix Patrons

Created on: 2017-12-20 13:18:37
Modified on: 2024-01-17 11:52:13
Date last run: 2025-05-04 17:00:54

----------

Public: 0
Expiry: 300

----------

 
Shows users who have attempted to login in to their account but failed.  Patrons with more than 5 failed attempts are locked out.
Shows any users who have failed logging in at least once.
at the library you specify - or with the card number you specify - or both
grouped by library card number
sorted by branchcode, patron's last name, patron's first name, and library card number

Notes:

Any user with permission to log into the staff client will have an indicator of "Staff" in the "ACCESS_TYPE" column.

Click here to run in a new window


----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.login_attempts,
  borrowers.updated_on AS LAST_LOGIN_ATTEMPT,
  If(borrowers.flags &gt; 0, "Staff", "-") AS ACCESS_TYPE,
  borrowers.email,
  IF(borrowers.login_attempts &gt; 4, "LOCKED OUT", "-") AS LOCKED
FROM
  borrowers
WHERE
  borrowers.login_attempts &gt; 0 AND
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.cardnumber LIKE &lt;&gt;
GROUP BY
  borrowers.cardnumber
ORDER BY
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.cardnumber

























