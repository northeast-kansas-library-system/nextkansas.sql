/*
R.001227

----------

Name: Your New Patrons
Created by: -

----------

Group: Borrowers
     -

Created on: 2011-11-01 16:10:52
Modified on: 2020-05-08 11:16:19
Date last run: 2022-12-06 16:14:51

----------

Public: 0
Expiry: 0

----------

Enhanced - Run, add numeric month, numeric year and pick your branch. #patrons

----------
*/



SELECT 
  borrowers.dateenrolled, 
  borrowers.surname, 
  borrowers.firstname, 
  borrowers.branchcode, 
  borrowers.categorycode, 
  borrowers.cardnumber, 
  borrowers.address, 
  borrowers.city, 
  borrowers.phone 
FROM borrowers 
WHERE month(dateenrolled) = << numericmonth >> AND 
  year(dateenrolled) = << numericyear >> AND 
  borrowers.branchcode = <<Pick your branch|branches>> 
ORDER BY borrowers.categorycode ASC

























