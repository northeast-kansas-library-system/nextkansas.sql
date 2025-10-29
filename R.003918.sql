/*
R.003918

----------

Name: 123
Created by: George Williams

----------

Group: -
     -

Created on: 2025-09-15 15:50:23
Modified on: 2025-09-15 16:06:23
Date last run: 2025-09-15 16:07:38

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode,
  '0' As login_attempts
From
  borrowers Left Join
  (Select
      accountlines.borrowernumber,
      Format(Sum(accountlines.amountoutstanding), 2) As DUE_SUM
    From
      accountlines
    Group By
      accountlines.borrowernumber) accountlinesx On borrowers.borrowernumber = accountlinesx.borrowernumber Left Join
  (Select
      issues.borrowernumber,
      Count(issues.issue_id) As ICOUNT
    From
      issues
    Group By
      issues.borrowernumber) issuesx On borrowers.borrowernumber = issuesx.borrowernumber Left Join
  (Select
      reserves.borrowernumber,
      Count(reserves.reserve_id) As Count_reserve_id
    From
      reserves
    Group By
      reserves.borrowernumber) requestsx On borrowers.borrowernumber = requestsx.borrowernumber Left Join
  (Select
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      authorised_values.lib,
      authorised_values.category
    From
      borrower_attributes Join
      authorised_values On borrower_attributes.attribute = authorised_values.authorised_value
    Where
      borrower_attributes.code = 'expired' And
      authorised_values.category = 'expired') expired_attribute On borrowers.borrowernumber =
      expired_attribute.borrowernumber Left Join
  (Select
      borrower_relationships.guarantor_id,
      Count(borrower_relationships.guarantee_id) As GCOUNT
    From
      borrower_relationships
    Group By
      borrower_relationships.guarantor_id) guaranteesx On guaranteesx.guarantor_id = borrowers.borrowernumber
Where
  borrowers.branchcode Like 'HIGH_CC' And
  borrowers.login_attempts <> '0'
Group By
  borrowers.dateexpiry,
  borrowers.borrowernumber
Order By
  borrowers.borrowernumber

























