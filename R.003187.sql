/*
R.003187

----------

Name: GHW - report to structure block information on patron pages
Created by: George Williams

----------

Group: -
     -

Created on: 2019-03-25 14:32:50
Modified on: 2024-01-17 11:54:47
Date last run: 2024-10-21 08:58:31

----------

Public: 0
Expiry: 1

----------

 
Returns the phrase "loginblock" when a patron ID is entered that has been unsuccessfully logged in more than the 'FailedLoginAttempts' system preference allows
Shows current blocks
for the patron is number you enter

Notes:

Designed to output a class that can be added to a page via JSON
Click here to run in a new window


----------
*/



SELECT
  If(borrowers.login_attempts &gt; 4, "loginblock", "") AS CLASS
FROM
  borrowers,
  (
    SELECT
      systempreferences.variable,
      systempreferences.value,
      systempreferences.options,
      systempreferences.explanation,
      systempreferences.type
    FROM
      systempreferences
    WHERE
      systempreferences.variable = 'FailedLoginAttempts'
  ) FAILEDLOGIN
WHERE
  borrowers.login_attempts &gt;= FAILEDLOGIN.value AND
  borrowers.borrowernumber = &lt;&gt;

























