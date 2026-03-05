/*
R.002971

----------

Name: GHW - EOM Cleanup 001
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2017-07-05 14:11:52
Modified on: 2024-01-17 11:51:49
Date last run: 2020-07-13 16:52:03

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows patrons who were added in the last 60 days but have no information in their "Registration Library" field.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows patrons added in the last 60 days without at registration library&lt;/li&gt;
&lt;li&gt;at any NExpress library&lt;/li&gt;
&lt;li&gt;grouped by patron barcode number&lt;/li&gt;
&lt;li&gt;sorted by STAFF_HOME_BRANCH and borrower.attribute&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2971&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

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

























