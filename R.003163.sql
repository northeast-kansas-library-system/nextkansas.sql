/*
R.003163

----------

Name: GHW - Locked accounts by borrowernumber
Created by: George Williams

----------

Group: -
     -

Created on: 2019-01-29 09:32:51
Modified on: 2024-10-19 17:31:26
Date last run: 2025-10-17 17:13:42

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Shows number of login attempts on a specific account.</p>
<ul><li>Shows current data</li>
<li>for the library card number you specify</li>
<li>grouped by library card number</li>
<li>sorted by patron's last name and card number</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>For the full instruction sheet for unlocking a patron's account after it has been locked due to too many login attempts, <a href="http://guides.nekls.org/assets/users/_gwilliams/account.lockout.pdf" target="_blank">click here</a></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3163&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>


----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  If(borrowers.login_attempts > 4,
    Concat(
      "This account is locked because of ",
      borrowers.login_attempts,
      " unsuccessful login attempts.The patron's p", 
      "assword must be reset/updated before they can log in."),
    "This account is not locked.") AS LOCKED,
  borrowers.login_attempts,
  borrowers.updated_on AS LAST_LOGIN_ATTEMPT
FROM
  borrowers
WHERE
  borrowers.borrowernumber LIKE <>
GROUP BY
  borrowers.cardnumber,
  borrowers.borrowernumber
ORDER BY
  borrowers.surname,
  borrowers.cardnumber  

























