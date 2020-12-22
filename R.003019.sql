/*
R.003019

----------

Name: GHW - Users with failed password login attempts
Created by: George H Williams

----------

Group: Patrons
     Fix Patrons

Created on: 2017-12-20 13:18:37
Modified on: 2018-05-29 11:17:57
Date last run: 2020-12-08 14:39:56

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Shows users who have attempted to login in to their account but failed.  Patrons with more than 5 failed attempts are locked out.</p>
<ul><li>Shows any users who have failed logging in at least once.</li>
<li>at the library you specify - or with the card number you specify - or both</li>
<li>grouped by library card number</li>
<li>sorted by branchcode, patron's last name, patron's first name, and library card number</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Any user with permission to log into the staff client will have an indicator of "Staff" in the "ACCESS_TYPE" column.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3019&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.login_attempts,
  borrowers.updated_on AS LAST_LOGIN_ATTEMPT,
  If(borrowers.flags > 0, "Staff", "-") AS ACCESS_TYPE,
  borrowers.email,
  IF(borrowers.login_attempts > 4, "<span style='color: red;'>LOCKED OUT</span>", "-") AS LOCKED
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



