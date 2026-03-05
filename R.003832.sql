/*
R.003832

----------

Name: GHW - super test
Created by: George Williams

----------

Group: -
     -

Created on: 2024-05-09 03:12:25
Modified on: 2024-05-09 03:12:25
Date last run: 2024-05-09 03:12:28

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  
  Concat_Ws('', 
    '<a ', 
    'class="btn noprint" ', 
    'href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&destination=circ&borrowernumber=', 
    borrowers.borrowernumber, 
    '" target="_blank">Edit borrower</a>' 
  ) AS LINK, 
  borrowers.surname,
  borrowers.firstname,
  borrowers.othernames,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.userid
FROM
  borrowers
WHERE 
  borrowers.surname like "Stub%"

























