/*
R.003019

----------

Name: GHW - Users with failed password login attempts
Created by: George Williams

----------

Group: Borrowers
     Fix Patrons

Created on: 2017-12-20 13:18:37
Modified on: 2025-12-29 23:21:46
Date last run: 2026-01-28 15:57:11

----------

Public: 0
Expiry: 300

----------

<div> 
<p>Shows users who have attempted to login in to their account but failed.  Patrons with more than 5 failed attempts are locked out.</p>
<ul><li>Shows any users who have failed logging in at least once.</li>
<li>at the library you specify - or with the card number you specify - or both</li>
<li>grouped by library card number</li>
<li>sorted by branchcode, patron's last name, patron's first name, and library card number</li>
</ul><br />
<p>Notes:</p>
<p></p>
<p>Any user with permission to log into the staff client will have an indicator of "Staff" in the "ACCESS_TYPE" column.</p>
<p></p>
<p>Click here to run in a new window</p>
</div>

----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.branchcode,
  borrowers.categorycode,
  Case
    WHEN borrowers.login_attempts = 6 THEN 'Account expired for more than 2 years - pasword locked automatically'
    ELSE borrowers.login_attempts
  END AS login_attempts,
  borrowers.updated_on AS LAST_LOGIN_ATTEMPT,
  If(borrowers.flags > 0, "Staff", "-") AS ACCESS_TYPE,
  borrowers.email,
  IF(borrowers.login_attempts > 4, "<span style='color: red;'>LOCKED OUT</span>", "-") AS LOCKED,
  borrowers.dateexpiry
FROM
  borrowers
WHERE
  borrowers.login_attempts > 0 AND
  borrowers.branchcode LIKE <<Choose patron home branch|LBRANCH>> AND
  borrowers.cardnumber LIKE <<OR -- Enter patron's card number or a % symbol to display all patrons>>
GROUP BY
  borrowers.cardnumber
ORDER BY
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.cardnumber

























