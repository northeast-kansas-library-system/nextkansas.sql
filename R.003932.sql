/*
R.003932

----------

Name: Test replacement
Created by: George Williams

----------

Group: -
     -

Created on: 2025-12-17 23:33:06
Modified on: 2025-12-17 23:55:24
Date last run: 2025-12-17 23:57:49

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branches.branchname As TRANSACTING_LIBRARY,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  categories.description As BORROWER_CATEGORY,
  Concat_Ws(' \n ', 
    Concat_Ws(' / ', 
      borrowers.firstname, 
      borrowers.surname
    ), 
    borrowers.address, 
    Concat(
      borrowers.city, 
      ', ', 
      borrowers.state, 
      ' ', 
      borrowers.zipcode
    )
  ) As CONTACT_INFO,
  borrowers.dateexpiry,
  expired_attributes.lib As EXPIRED_ATTRIBUTE,
  borrowers.email,
  borrowers.phone,
  borrowers.branchcode As BORROWER_HOME_LIBRARY,
  outstanding_fees.date As DATE_OF_FEE,
  outstanding_fees.amount As AMOUNT_OF_FEE,
  outstanding_fees.amountoutstanding As UNPAID_BALANCE,
  outstanding_fees.description As DESCRIPTION,
  outstanding_fees.NOTE As NOTE,
  account_debit_types.description As DEBIT_TYPE,
  fee_status.lib As FEE_STATUS,
  interface.lib AS FEE_CREATED_BY,
  outstanding_fees.FEE_BRANCH As FEE_OWNED_BY,
  outstanding_fees.accountlines_id
From
  borrowers Join
  (
    Select
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.old_issue_id,
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.amountoutstanding,
      accountlines.description,
      Trim(Replace(Replace(accountlines.note, Char(10), ' '), Char(13), ' ')) As NOTE,
      Coalesce(accountlines.debit_type_code, 'FINE') As debit_type_code,
      accountlines.status,
      accountlines.manager_id,
      Coalesce(accountlines.interface, ' ') As interface,
      If(accountlines.branchcode Is Not Null, accountlines.branchcode, issues.branchcode) As FEE_BRANCH
    From
      accountlines Join
      issues On accountlines.issue_id = issues.issue_id
    Where
      accountlines.issue_id Is Not Null And
      accountlines.amountoutstanding > 0
    Union
    Select
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.old_issue_id,
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.amountoutstanding,
      accountlines.description,
      Trim(Replace(Replace(accountlines.note, Char(10), ' '), Char(13), ' ')) As NOTE,
      Coalesce(accountlines.debit_type_code, 'FINE') As debit_type_code,
      accountlines.status,
      accountlines.manager_id,
      Coalesce(accountlines.interface, ' ') As interface,
      If(accountlines.branchcode Is Not Null, accountlines.branchcode, old_issues.branchcode) As FEE_BRANCH
    From
      accountlines Join
      old_issues On accountlines.old_issue_id = old_issues.issue_id
    Where
      accountlines.amountoutstanding > 0 And
      accountlines.old_issue_id Is Not Null
    Union
    Select
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.old_issue_id,
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.amountoutstanding,
      accountlines.description,
      Trim(Replace(Replace(accountlines.note, Char(10), ' '), Char(13), ' ')) As NOTE,
      Coalesce(accountlines.debit_type_code, 'FINE') As debit_type_code,
      accountlines.status,
      accountlines.manager_id,
      Coalesce(accountlines.interface, ' ') As interface,
      If(accountlines.branchcode Is Not Null, accountlines.branchcode, items.homebranch) As FEE_BRANCH
    From
      accountlines Left Join
      items On accountlines.itemnumber = items.itemnumber
    Where
      accountlines.amountoutstanding > 0 And
      accountlines.old_issue_id Is Null And
      accountlines.issue_id Is Null And
      accountlines.itemnumber Is Not Null
    Union
    Select
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.old_issue_id,
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.amountoutstanding,
      accountlines.description,
      Trim(Replace(Replace(accountlines.note, Char(10), ' '), Char(13), ' ')) As NOTE,
      Coalesce(accountlines.debit_type_code, 'FINE') As debit_type_code,
      accountlines.status,
      accountlines.manager_id,
      Coalesce(accountlines.interface, ' ') As interface,
      If(accountlines.branchcode Is Not Null, accountlines.branchcode, borrowers.branchcode) As FEE_BRANCH
    From
      accountlines Left Join
      borrowers On accountlines.borrowernumber = borrowers.borrowernumber
    Where
      accountlines.amountoutstanding > 0 And
      accountlines.old_issue_id Is Null And
      accountlines.issue_id Is Null And
      accountlines.itemnumber Is Null
    ) outstanding_fees 
      On outstanding_fees.borrowernumber = borrowers.borrowernumber
  Join branches 
    On outstanding_fees.FEE_BRANCH = branches.branchcode 
  Left Join categories 
    On borrowers.categorycode = categories.categorycode 
  Left Join account_debit_types 
    On account_debit_types.code = outstanding_fees.debit_type_code 
  Left Join
  (
    Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'Z_FEE_STATUS'
  ) fee_status 
    On fee_status.authorised_value = outstanding_fees.status
  Left Join
  (
    Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'Z_INTERFACE'
  ) interface 
    On interface.authorised_value = outstanding_fees.interface
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
  ) expired_attributes 
    On expired_attributes.borrowernumber = outstanding_fees.borrowernumber
Where
  branches.branchcode Like <<Choose your library|LBRANCH>> And
  borrowers.categorycode Like  <<Borrower category|categorycode:all>>  And
  outstanding_fees.debit_type_code Like  <<Debit type|debit_types:all>>  And
  outstanding_fees.interface Like <<Free created by|Z_INTERFACE>> And
  Coalesce(expired_attributes.attribute, '-') Like <<Expired attribute|EXPIRED:all>> And
  borrowers.cardnumber Like Concat('%', <<Enter a library card number or a % symbol>>, '%')
Group By
  branches.branchname,
  borrowers.borrowernumber,
  outstanding_fees.accountlines_id
Order By
  TRANSACTING_LIBRARY,
  borrowers.borrowernumber

























