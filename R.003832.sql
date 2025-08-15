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
    'Edit borrower' 
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

























