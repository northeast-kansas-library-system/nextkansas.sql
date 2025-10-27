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

 
Shows number of login attempts on a specific account.
Shows current data
for the library card number you specify
grouped by library card number
sorted by patron's last name and card number

Notes:

For the full instruction sheet for unlocking a patron's account after it has been locked due to too many login attempts, click here

Click here to run in a new window



----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  If(borrowers.login_attempts &gt; 4,
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
  borrowers.borrowernumber LIKE &lt;&gt;
GROUP BY
  borrowers.cardnumber,
  borrowers.borrowernumber
ORDER BY
  borrowers.surname,
  borrowers.cardnumber  

























