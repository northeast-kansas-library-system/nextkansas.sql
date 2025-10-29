/*
R.003882

----------

Name: Sandbox
Created by: George Williams

----------

Group: -
     -

Created on: 2025-04-24 14:48:51
Modified on: 2025-06-02 14:20:18
Date last run: 2025-06-02 14:16:42

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
    borrowers.borrowernumber,
    borrowers.cardnumber,
    borrowers.branchcode,
    borrowers.categorycode,
    If(borrowers.dateexpiry < Now(), Concat('Borrower registration expired on ', borrowers.dateexpiry), '') As REASON_1,
    If(borrower_restrictions.restricted > 1, 'Borrower is restricted', '') As REASON_2,
    If(amount_outstanding.amount >= 10, Concat('Borrower owes ', amount_outstanding.amount), '') As REASON_3,
    If(overdues.Count_issue_id = 1, Concat('Borrower has 1 overdue item'), If(overdues.Count_issue_id > 1, Concat('Borrower has ', overdues.Count_issue_id, ' overdue items'), '')) As REASON_3
From
    borrowers Left Join
    (Select
         borrower_debarments.borrowernumber,
         Sum(borrower_debarments.borrower_debarment_id) As restricted
     From
         borrower_debarments
     Group By
         borrower_debarments.borrowernumber) borrower_restrictions On borrower_restrictions.borrowernumber =
            borrowers.borrowernumber Left Join
    (Select
         accountlines.borrowernumber,
         ROUND(Sum(accountlines.amountoutstanding), 2) As amount
     From
         accountlines
     Group By
         accountlines.borrowernumber) amount_outstanding On amount_outstanding.borrowernumber = borrowers.borrowernumber
    Left Join
    (Select
         issues.borrowernumber,
         Count(Distinct issues.issue_id) As Count_issue_id,
         issues.date_due As Overdue
     From
         issues
     Where
         issues.date_due < CurDate()
     Group By
         issues.borrowernumber) overdues On overdues.borrowernumber = borrowers.borrowernumber
Where
    borrowers.branchcode Like <> And
    borrowers.categorycode Like '%'
Group By
    borrowers.borrowernumber
Order By
    borrowers.branchcode,
    borrowers.cardnumber

























