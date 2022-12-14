/*
R.003681

----------

Name: Administrative Report - Duplicate Userids
Created by: -

----------

Group: -
     -

Created on: -
Modified on: 2022-11-21 17:33:54
Date last run: 2022-12-14 11:52:36

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  userid, 
  email, 
  group_concat(cardnumber SEPARATOR ', ') as cards, 
  group_concat(concat(firstname, ' ', surname) SEPARATOR '; ') as names,
  GROUP_CONCAT(branchcode  SEPARATOR ', ') as branches 
FROM borrowers 
GROUP BY userid 
HAVING COUNT(borrowernumber) > 1

























