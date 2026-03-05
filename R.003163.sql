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
Date last run: 2026-01-28 16:33:12

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows number of login attempts on a specific account.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current data&lt;/li&gt;
&lt;li&gt;for the library card number you specify&lt;/li&gt;
&lt;li&gt;grouped by library card number&lt;/li&gt;
&lt;li&gt;sorted by patron's last name and card number&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;For the full instruction sheet for unlocking a patron's account after it has been locked due to too many login attempts, &lt;a href="http://guides.nekls.org/assets/users/_gwilliams/account.lockout.pdf" target="_blank"&gt;click here&lt;/a&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3163&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;


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

























