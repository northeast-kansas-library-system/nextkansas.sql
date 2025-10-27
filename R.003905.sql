/*
R.003905

----------

Name: GHW - Patron Purge 100
Created by: George Williams

----------

Group: -
     -

Created on: 2025-07-31 09:38:20
Modified on: 2025-07-31 09:38:20
Date last run: 2025-10-27 09:30:49

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
  '6' AS login_attempts
From
  borrowers Left Join
  (
    Select
      accountlines.borrowernumber,
      Format(Sum(accountlines.amountoutstanding), 2) As DUE_SUM
    From
      accountlines
    Group By
      accountlines.borrowernumber
  ) accountlinesx 
    On borrowers.borrowernumber = accountlinesx.borrowernumber Left Join
  (
    Select
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
      reserves.borrowernumber
  ) requestsx 
    On borrowers.borrowernumber = requestsx.borrowernumber 
  Left Join
  (
    Select
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
      authorised_values.category = 'expired'
  ) expired_attribute 
    On borrowers.borrowernumber = expired_attribute.borrowernumber 
  Left Join
  (
    Select
      borrower_relationships.guarantor_id,
      Count(borrower_relationships.guarantee_id) As GCOUNT
    From
      borrower_relationships
    Group By
      borrower_relationships.guarantor_id
  ) guaranteesx 
    On guaranteesx.guarantor_id = borrowers.borrowernumber
Where
  borrowers.dateexpiry Between CurDate() - Interval 1095 Day And CurDate() - Interval 730.5 Day And
  borrowers.branchcode Like '%' And
  Coalesce(borrowers.othernames, "0") Not Like "%SIP%" And
  borrowers.categorycode &lt;&gt; 'STAFF' And
  borrowers.categorycode &lt;&gt; 'ILL' And
  borrowers.categorycode &lt;&gt; 'HOOPLA' And
  Coalesce(requestsx.Count_reserve_id, 0) = 0 And
  Coalesce(expired_attribute.attribute, 0) &lt;&gt; 1 And
  Coalesce(expired_attribute.attribute, 0) &lt;&gt; 2
Group By
  borrowers.borrowernumber
Order By
  borrowers.borrowernumber

























