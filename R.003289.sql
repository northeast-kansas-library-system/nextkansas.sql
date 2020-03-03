/*
R.003289

----------

Name: GHW - Leavenworth - LEAVENWRTH Kanopy users with non-LEAVENWRTH home library
Created by: George H Williams

----------

Group: Library-Specific
     Leavenworth

Created on: 2019-12-27 10:42:30
Modified on: 2019-12-27 10:48:25
Date last run: 2019-12-27 10:46:02

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a href="/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=', borrowers.borrowernumber, '&step=4" target="_blank">Edit this borrower\'s attributes</a>') AS LINK,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.branchcode AS BORROWERS_HOME_LIBRARY,
  borrower_attributes.attribute
FROM
  borrowers
  INNER JOIN borrower_attributes
    ON borrower_attributes.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode <> 'LEAVENWRTH' AND
  borrower_attributes.code = 'LEAVKANOPY' AND
  borrower_attributes.attribute = 'LEAVENWRTH'



