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

 
Shows patrons who were added in the last 60 days but have no information in their "Registration Library" field.
Shows patrons added in the last 60 days without at registration library
at any NExpress library
grouped by patron barcode number
sorted by STAFF_HOME_BRANCH and borrower.attribute

Notes:

Click here to run in a new window


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

























