/*
R.000582

----------

Name: OUTSTANDING Fines by patron home library
Created by:  Tongie Book Club

----------

Group: Circulation
     Charges

Created on: 2009-06-12 16:22:06
Modified on: 2021-08-17 12:55:08
Date last run: 2023-05-15 13:14:50

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Generates a list of all patrons with fees on their account</p>
<ul><li>Lists patrons that currently have an account balance due greater than $0.01</li>
<li>lists patrons whose home library is the branchcode you specify - regardless of where the fees were generated.</li>
<li>grouped by the borrower's card number</li>
<li>sorted by the borrowers last name</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Explanatory notes added by GHW on 2017.04.20.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=582&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  Format(Sum(accountlines.amountoutstanding), 2) AS AMT_DUE
FROM
  borrowers
  LEFT JOIN accountlines ON borrowers.borrowernumber = accountlines.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Borrowers home branch|ZBRAN>>
GROUP BY
  borrowers.cardnumber
HAVING
  AMT_DUE > 0
ORDER BY
  borrowers.surname

























