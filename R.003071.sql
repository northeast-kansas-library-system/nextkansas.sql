/*
R.003071

----------

Name: GHW - Restrictions no longer needed
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-04-13 16:53:35
Modified on: 2020-01-09 11:44:09
Date last run: 2022-08-10 12:14:27

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Reports on patrons who have had a restriction added to their account due to an overdue item but the item has been returned and their fees are less than $10.00</p>
<ul><li>Shows patrons who currently have restrictions created by the overdues process, no overdues, and less than $10.00 in fees</li>
<li>at all Next libraries</li>
<li>grouped by borrowernumber</li>
<li>sorted by borrower home branch, borrowers last name, borrowers first name</li>
<li>links directly to the restriction page of the borrower</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3071&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat("<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", borrowers.borrowernumber, "#reldebarments' target='_blank'>Go to patron</a>") AS LINK_TO_BORROWER,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.debarred,
  borrowers.debarredcomment,
  fees.SUM
FROM
  borrowers
  LEFT JOIN (
    SELECT
      issues.borrowernumber,
      issues.itemnumber,
      issues.date_due
    FROM
      issues
    WHERE
      issues.date_due < Now()
    GROUP BY
      issues.borrowernumber,
      issues.itemnumber,
      issues.date_due
  ) overdues
    ON borrowers.borrowernumber = overdues.borrowernumber
  LEFT JOIN (
    SELECT
      accountlines.borrowernumber,
      Group_Concat(accountlines.accounttype) AS Group_Concat_accounttype,
      Sum(accountlines.amountoutstanding) AS SUM
    FROM
      accountlines
    WHERE
      accountlines.amountoutstanding > 0
    GROUP BY
      accountlines.borrowernumber
  ) fees
    ON borrowers.borrowernumber = fees.borrowernumber
WHERE
  borrowers.debarred IS NOT NULL AND
  (borrowers.debarredcomment IS NULL OR
    (borrowers.debarredcomment LIKE "%overdue%" AND
      borrowers.debarredcomment LIKE "%process%")) AND
  fees.Group_Concat_accounttype NOT LIKE "L%" AND
  fees.Group_Concat_accounttype NOT LIKE "D%" AND
  fees.Group_Concat_accounttype NOT LIKE "A%" AND
  fees.Group_Concat_accounttype NOT LIKE "P%" AND
  fees.Group_Concat_accounttype NOT LIKE "M%" AND
  fees.Group_Concat_accounttype NOT LIKE "C%" AND
  (Char_Length(borrowers.debarredcomment) = 33 OR
    Char_Length(borrowers.debarredcomment) = 54 OR
    (borrowers.debarredcomment IS NULL)) AND
  Coalesce(borrowers.gonenoaddress, 0) < 1 AND
  Coalesce(borrowers.lost, 0) < 1 AND
  fees.SUM <= 10
GROUP BY
  borrowers.borrowernumber
HAVING
  Count(DISTINCT overdues.itemnumber) = 0
ORDER BY
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname

























