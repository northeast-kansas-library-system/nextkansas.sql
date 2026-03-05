/*
R.003742

----------

Name: Trim name fields
Created by: George Williams

----------

Group: -
     -

Created on: 2023-07-24 14:06:47
Modified on: 2023-08-02 16:47:33
Date last run: 2024-05-09 03:10:55

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
  borrowers.firstname LIKE "%  %" OR 
  borrowers.surname LIKE "%  %" OR
  borrowers.firstname LIKE " %" OR 
  borrowers.surname LIKE " %" OR
  borrowers.firstname LIKE "% " OR 
  borrowers.surname LIKE "% "
ORDER BY
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.cardnumber,
  borrowers.surname

























