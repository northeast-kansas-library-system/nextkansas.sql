/*
R.003309

----------

Name: GHW - LEAVENWRTH - patrons with YES newsletter permission - new and renewed yesterday
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-01-30 12:21:42
Modified on: 2020-01-30 12:21:59
Date last run: 2020-08-19 03:00:03

----------

Public: 0
Expiry: 300

----------



----------
*/

Select
  borrowers.branchcode,
  borrowers.cardnumber,
  Concat(borrowers.surname, ", ", borrowers.firstname) As BORROWER_NAME,
  borrowers.email,
  Concat(newsletter.code, ", ", newsletter.lib) As PERMISSION,
  borrowers.dateenrolled,
  borrowers.date_renewed
From
  borrowers Left Join
  (Select
     borrower_attributes.borrowernumber,
     borrower_attributes.code,
     authorised_values.lib,
     authorised_values.authorised_value
   From
     borrower_attributes Inner Join
     borrower_attribute_types On borrower_attributes.code = borrower_attribute_types.code Inner Join
     authorised_values On borrower_attribute_types.authorised_value_category = authorised_values.category And
         borrower_attributes.attribute = authorised_values.authorised_value
   Where
     borrower_attributes.code = 'NEWSLETTER') newsletter On borrowers.borrowernumber = newsletter.borrowernumber
Where
  borrowers.branchcode Like 'LEAVENWRTH' And
  Coalesce(newsletter.authorised_value, 'NotAsked') Like 'Yes' And
  (borrowers.dateenrolled = CurDate() - Interval 1 Day Or
      borrowers.date_renewed = CurDate() - Interval 1 Day)
Group By
  borrowers.cardnumber,
  borrowers.email,
  borrowers.dateenrolled,
  borrowers.date_renewed,
  Coalesce(newsletter.authorised_value, 'NotAsked')
Order By
  borrowers.branchcode,
  BORROWER_NAME



