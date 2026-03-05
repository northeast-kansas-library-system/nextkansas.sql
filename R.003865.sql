/*
R.003865

----------

Name: GHW - Koha permission attributes
Created by: George Williams

----------

Group: -
     -

Created on: 2024-10-20 22:48:44
Modified on: 2024-10-20 22:56:23
Date last run: 2026-01-28 15:04:47

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branches.branchname,
  borrowers.cardnumber,
  borrowers.userid,
  Concat_Ws('', 
    borrowers.surname, 
    ', ', 
    borrowers.firstname, 
    ' ', 
    borrowers.middle_name, 
    If(
      Coalesce(borrowers.othernames, '') != '', 
      Concat(' (', borrowers.othernames, ')'), 
      ''
    )
  ) As NAME,
  borrowers.email,
  categories.description As description1,
  authorised_values.lib
From
  borrower_attribute_types Join
  borrower_attributes On borrower_attributes.code = borrower_attribute_types.code Join
  authorised_values On authorised_values.authorised_value = borrower_attributes.attribute Join
  borrowers On borrower_attributes.borrowernumber = borrowers.borrowernumber Join
  categories On borrowers.categorycode = categories.categorycode Join
  branches On borrowers.branchcode = branches.branchcode
Where
  borrower_attribute_types.code Like 'ST_KOHA' And
  authorised_values.category = 'PA_P_KOHA' And
  authorised_values.authorised_value Like <<Choose Koha permission attribute|PA_P_KOHA:all>> AND 
  borrowers.branchcode LIKE <<Choose your library|LBRANCH>>
Group By
  borrowers.borrowernumber
Order By
  branches.branchname, 
  NAME

























