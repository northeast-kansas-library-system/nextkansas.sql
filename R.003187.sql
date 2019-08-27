/*
R.003187

----------

Name: GHW - report to structure block information on patron pages
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-03-25 14:32:50
Modified on: 2019-04-03 16:15:45
Date last run: 2019-08-27 15:54:04

----------

Public: 0
Expiry: 1

----------

<div id=reportinfo>
<p>Returns the phrase "loginblock" when a patron ID is entered that has been unsuccessfully logged in more than the 'FailedLoginAttempts' system preference allows</p>
<ul><li>Shows current blocks</li>
<li>for the patron is number you enter</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Designed to output a class that can be added to a page via JSON</p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3187&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  If(borrowers.login_attempts > 4, "loginblock", "") AS CLASS
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
  borrowers.login_attempts >= FAILEDLOGIN.value AND
  borrowers.borrowernumber = <<enter borrower id>>



