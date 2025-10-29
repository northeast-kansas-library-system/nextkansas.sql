/*
R.003864

----------

Name: GHW - Aspen Discovery permission attributes
Created by: George Williams

----------

Group: -
     -

Created on: 2024-10-20 22:35:17
Modified on: 2024-10-20 23:40:15
Date last run: 2024-10-21 11:02:01

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
  borrower_attribute_types.code Like 'ST_ASPEN' And
  authorised_values.category = 'PA_P_ASPEN' And
  authorised_values.authorised_value Like <> AND 
  borrowers.branchcode LIKE <>
Group By
  borrowers.borrowernumber
Order By
  branches.branchname, 
  NAME

























