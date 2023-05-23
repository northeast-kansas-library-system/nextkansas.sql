/*
R.000579

----------

Name: Debarred patrons
Created by:  Tongie Book Club

----------

Group: Borrowers
     -

Created on: 2009-06-12 15:39:47
Modified on: 2023-03-29 10:40:46
Date last run: 2023-03-29 10:40:52

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT 
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.debarred,
  borrowers.flags
FROM 
  borrowers
WHERE 
  borrowers.branchcode = <<Choose your library|branches>>
  AND borrowers.debarred IS NOT NULL

























