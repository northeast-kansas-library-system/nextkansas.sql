/*
R.002971

----------

Name: GHW - EOM Cleanup 001
Created by: George H Williams

----------

Group: Patrons
     Patron attributes

Created on: 2017-07-05 14:11:52
Modified on: 2019-07-24 17:48:07
Date last run: 2019-07-24 17:44:25

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Shows patrons who were added in the last 60 days but have no information in their "Registration Library" field.</p>
<ul><li>Shows patrons added in the last 60 days without at registration library</li>
<li>at any NExpress library</li>
<li>grouped by patron barcode number</li>
<li>sorted by STAFF_HOME_BRANCH and borrower.attribute</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2971&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  borrowers.cardnumber,
  branches.branchname AS STAFF_HOME_BRANCH,
  regbranch.attribute
FROM
  borrowers
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        borrower_attributes.code,
        borrower_attributes.attribute
      FROM
        borrower_attributes
      WHERE
        borrower_attributes.code = 'REGBRANCH') regbranch ON borrowers.borrowernumber = regbranch.borrowernumber
  JOIN action_logs ON action_logs.object = borrowers.borrowernumber
  JOIN borrowers staff ON action_logs.user = staff.borrowernumber
  INNER JOIN branches ON staff.branchcode = branches.branchcode
WHERE
  regbranch.attribute IS NULL AND
  action_logs.module = 'MEMBERS' AND
  action_logs.action LIKE 'CREAT%'
GROUP BY
  staff.branchcode,
  branches.branchname,
  borrowers.borrowernumber
ORDER BY
  STAFF_HOME_BRANCH,
  regbranch.attribute



