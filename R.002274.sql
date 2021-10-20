/*
R.002274

----------

Name: Data in the borrowers table that needs to be deleted
Created by: Heather Braum

----------

Group: Administrative Reports
     Patrons-admin

Created on: 2014-06-05 15:14:42
Modified on: 2019-02-10 21:11:55
Date last run: 2019-06-19 15:41:48

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=', borrowers.borrowernumber,
  '\" target="_blank">edit patron</a>') AS EDIT_PATRON,
  borrowers.branchcode,
  borrowers.contactnote,
  borrowers.borrowernotes
FROM
  borrowers
WHERE
  (borrowers.contactnote REGEXP '[0-9]{3}\-?[0-9]{2}\-?[0-9]{4}' OR
    borrowers.borrowernotes REGEXP '[0-9]{3} ?\-? ?[0-9]{2} ?\-? ?[0-9]{4}')
ORDER BY
  borrowers.branchcode

























