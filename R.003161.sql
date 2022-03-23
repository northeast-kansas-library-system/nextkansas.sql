/*
R.003161

----------

Name: GHW - Patrons added in the previous calendar month
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-01-27 23:01:25
Modified on: 2019-01-28 01:30:09
Date last run: 2022-02-10 14:30:54

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of new patrons to review for input errors</p>
<ul><li>Shows patrons added in the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped by borrowernumber</li>
<li>sorted by the patron's last name and first name</li>
<li>contains links to the edit patron screen for each patron</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Partially replaces report 555</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3161&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat(
    '<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',
    borrowers.borrowernumber,
    '\" target="_blank">edit patron</a>'
  ) AS "edit patron",
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.email,
  borrowers.phone,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE <<Choose the patron home library|LBRANCH>> AND
  Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) AND
  Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH)
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode

























