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

&lt;div&gt; 
&lt;p&gt;Shows users who have attempted to login in to their account but failed.  Patrons with more than 5 failed attempts are locked out.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows any users who have failed logging in at least once.&lt;/li&gt;
&lt;li&gt;at the library you specify - or with the card number you specify - or both&lt;/li&gt;
&lt;li&gt;grouped by library card number&lt;/li&gt;
&lt;li&gt;sorted by branchcode, patron's last name, patron's first name, and library card number&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;Notes:&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Any user with permission to log into the staff client will have an indicator of "Staff" in the "ACCESS_TYPE" column.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Click here to run in a new window&lt;/p&gt;
&lt;/div&gt;

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
  If(borrowers.flags &gt; 0, "Staff", "-") AS ACCESS_TYPE,
  borrowers.email,
  IF(borrowers.login_attempts &gt; 4, "LOCKED OUT", "-") AS LOCKED,
  borrowers.dateexpiry
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

























