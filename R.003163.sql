/*
R.003163

----------

Name: GHW - Locked accounts by borrowernumber
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-01-29 09:32:51
Modified on: 2019-06-05 18:22:44
Date last run: 2020-08-11 15:46:27

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
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
      "<span style='color: red;'>This account is locked because of ",
      borrowers.login_attempts,
      " unsuccessful login attempts.<br />The patron's password must be reset/updated before they can log in.</span>"),
    "This account is not locked.") AS LOCKED,
  borrowers.login_attempts,
  borrowers.updated_on AS LAST_LOGIN_ATTEMPT
FROM
  borrowers
WHERE
  borrowers.borrowernumber LIKE <<Enter a borrowernumber or a % symbol>>
GROUP BY
  borrowers.cardnumber,
  borrowers.borrowernumber
ORDER BY
  borrowers.surname,
  borrowers.cardnumber  



