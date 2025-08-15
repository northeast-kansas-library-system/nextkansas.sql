/*
R.003821

----------

Name: GHW report template test
Created by: George Williams

----------

Group: -
     -

Created on: 2024-04-04 18:28:28
Modified on: 2024-04-05 10:54:10
Date last run: 2024-04-05 11:50:21

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  borrowers.firstname,
  borrowers.surname,
  borrowers.cardnumber,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.phone,
  borrowers.email,
  borrowers.emailpro,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  branches.branchname,
  categories.description
From
  borrowers Join
  branches On borrowers.branchcode = branches.branchcode Join
  categories On borrowers.categorycode = categories.categorycode
Where
  borrowers.borrowernumber = 295358

























