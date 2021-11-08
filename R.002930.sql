/*
R.002930

----------

Name: GHW - Patrons with outstanding fees based on fee-creating branch
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-04-26 12:32:24
Modified on: 2019-12-26 11:46:38
Date last run: 2021-11-03 19:33:55

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Lists all patrons with outstanding fees based on the library that "owns" the fee (see the notes below for the definition of which library owns the fee)</p>
<ul><li>Shows patrons with outstanding balances due</li>
<li>shows patrons with fees that are owned by the library you specify, with a fee type you specify, and/or by the patron's home library</li>
<li>also allows you to limit the results to show all patrons, only patrons with items checked out, or only patrons with no items currently checked out</li>
<li>grouped by patron card number and accountlines ID</li>
<li>sorted by the patron's last name, first name, and card number</li>
<li>contains links to the account tab on the patron's account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Determining which library a fee belongs to can be very complicated in Koha.  This report makes that determination as follows:
  <ul>
    <li>If the accountlines table indicates the staff login (i.e. NEKLSCIRC, OTTATECH, HORTDIRECTOR) who created a fee, the staff login's home library is the library that owns the fee</li>
    <li>If the accountlines table does not indicate a staff login and the item was checked out less than 13 months ago, the checkout is linked to the library where the item was checked out by connecting accountlines to the to the old_issues table (we purge data more than 13 months old from the old_issues table)</li>
    <li>If the accountlines table does not indicate a staff login and the item was checked out more than 13 months ago, it's assumed that the patron's home library owns the fee</li>
    <li>If the accountlines table does not indicate a staff login and the item is currently checked out to the patron, the checkout is linked to the library where the item was checked out by connecting accountlines to the issues table</li>
  </ul>
</p>
<p></p>
<p>Updated on 2019.03.15 by GHW</p>
<p></p>
<p>Report created by George Williams.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2930&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

<p><span style="color: yellow; background-color: red; font-size: 200%;">References accountlines.accounttype.  Needs to be updated after January 4, 2020</span></p>

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/members/boraccount.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">Link to fees</a>') AS 'LINK',
  Upper(borrowers.cardnumber) AS CARDNUMBER,
  borrowers.firstname,
  borrowers.surname,
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.email,
  borrowers.phone,
  borrowers.branchcode,
  If(Count(DISTINCT issues.issue_id) > 0, "Yes", "No") AS HAS_ITEMS_OUT,
  Count(DISTINCT issues.issue_id) AS CURRENT_CKO_COUNT,
  outstanding.date AS FEE_DATE,
  If(
    outstanding.accounttype = "L", "Lost Item",
    If(
      outstanding.accounttype LIKE "F%", "Fine",
      If(
        outstanding.accounttype = "A", "Account management fee",
        If(
          outstanding.accounttype = "N", "New card",
          If(
            outstanding.accounttype = "M", "Sundry",
            If(
              outstanding.accounttype LIKE "C%", "Copier fees",
              If(
                outstanding.accounttype LIKE "D%", "Damaged item",
                "-"
              )
            )
          )
        )
      )
    )
  ) AS TYPE_OF_FEE,
  Format(outstanding.amount, 2) AS FULL_FEE_AMOUNT,
  outstanding.accountlines_id,
  outstanding.description AS FEE_DESCRIPTION,
  outstanding.note AS FEE_NOTE,
  Format(Sum(outstanding.amount - outstanding.amountoutstanding), 2) AS PAID_SO_FAR,
  If(Sum(outstanding.amount > outstanding.amountoutstanding), CAST(outstanding.timestamp AS DATE), "-") AS MOST_RECENT_PAYMENT,
  Format(outstanding.amountoutstanding, 2) AS AMOUNT_OUTSTANDING
FROM
  (
    SELECT
      accountlines.accountlines_id,
      accountlines.borrowernumber,
      accountlines.accountno,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.description,
      accountlines.accounttype,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.lastincrement,
      accountlines.note,
      accountlines.manager_id,
      borrowers.branchcode
    FROM
      accountlines
      JOIN borrowers
        ON borrowers.borrowernumber = accountlines.manager_id
    WHERE
      accountlines.amountoutstanding > 0 AND
      borrowers.branchcode LIKE @brn := <<Choose library where the fee was created|LBRANCH>> COLLATE utf8mb4_unicode_ci
    UNION
    SELECT
      accountlines.accountlines_id,
      accountlines.borrowernumber,
      accountlines.accountno,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.description,
      accountlines.accounttype,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.lastincrement,
      accountlines.note,
      accountlines.manager_id,
      old_issues.branchcode
    FROM
      accountlines
      JOIN old_issues
        ON old_issues.borrowernumber = accountlines.borrowernumber AND
        old_issues.itemnumber = accountlines.itemnumber
    WHERE
      accountlines.amountoutstanding > 0 AND
      old_issues.branchcode LIKE  @brn AND
      accountlines.manager_id IS NULL
    UNION
    SELECT
      accountlines.accountlines_id,
      accountlines.borrowernumber,
      accountlines.accountno,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.description,
      accountlines.accounttype,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.lastincrement,
      accountlines.note,
      accountlines.manager_id,
      borrowers.branchcode
    FROM
      accountlines
      INNER JOIN borrowers
        ON borrowers.borrowernumber = accountlines.borrowernumber
    WHERE
      accountlines.accountlines_id NOT IN (
          SELECT
            accountlines.accountlines_id
          FROM
            accountlines
            JOIN old_issues
              ON old_issues.borrowernumber = accountlines.borrowernumber AND
              old_issues.itemnumber = accountlines.itemnumber
          WHERE
            accountlines.amountoutstanding > 0 AND
            old_issues.branchcode LIKE @brn AND
            accountlines.manager_id IS NULL
          UNION
          SELECT
            accountlines.accountlines_id
          FROM
            accountlines
            JOIN issues
              ON issues.borrowernumber = accountlines.borrowernumber AND
              issues.itemnumber = accountlines.itemnumber
          WHERE
            accountlines.amountoutstanding > 0 AND
            issues.branchcode LIKE @brn AND
            accountlines.manager_id IS NULL
        ) AND
      accountlines.amountoutstanding > 0 AND
      borrowers.branchcode LIKE @brn AND
      accountlines.manager_id IS NULL
    UNION
    SELECT
      accountlines.accountlines_id,
      accountlines.borrowernumber,
      accountlines.accountno,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.description,
      accountlines.accounttype,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.lastincrement,
      accountlines.note,
      accountlines.manager_id,
      issues.branchcode
    FROM
      accountlines
      JOIN issues
        ON issues.borrowernumber = accountlines.borrowernumber AND
        issues.itemnumber = accountlines.itemnumber
    WHERE
      accountlines.amountoutstanding > 0 AND
      issues.branchcode LIKE @brn AND
      accountlines.manager_id IS NULL
  ) outstanding
  JOIN borrowers
    ON borrowers.borrowernumber = outstanding.borrowernumber
  LEFT JOIN issues
    ON issues.borrowernumber = borrowers.borrowernumber
WHERE
  If(
    outstanding.accounttype = "L", "Lost Item",
    If(
      outstanding.accounttype LIKE "F%", "Fine",
      If(
        outstanding.accounttype = "A", "Account management fee",
        If(
          outstanding.accounttype = "N", "New card",
          If(
            outstanding.accounttype = "M", "Sundry",
            If(
              outstanding.accounttype LIKE "C%", "Copier fees",
              If(
                outstanding.accounttype LIKE "D%", "Damaged item",
                "-"
              )
            )
          )
        )
      )
    )
  ) LIKE <<Select fee type|LFTYPE>> AND
  borrowers.branchcode LIKE <<Select patron home library|LBRANCH>>
GROUP BY
  Upper(borrowers.cardnumber),
  outstanding.accountlines_id
HAVING
  HAS_ITEMS_OUT LIKE <<Patron currently has items checked out?|ZYES_NO>>
ORDER BY
  borrowers.surname,
  borrowers.firstname,
  borrowers.cardnumber

























