/*
R.002938

----------

Name: GHW - Unique Management Report
Created by: George Williams

----------

Group: -
     -

Created on: 2017-05-02 16:50:04
Modified on: 2019-12-26 11:46:44
Date last run: 2020-02-22 19:33:12

----------

Public: 0
Expiry: 0

----------

<p><span style="color: yellow; background-color: red; font-size: 200%;">References accountlines.accounttype.  Needs to be updated after January 4, 2020</span></p>

----------
*/



SELECT
  CONCAT( 'Link to fees' ) AS 'LINK',
  Upper(borrowers.cardnumber) AS CARDNUMBER,
  borrowers.surname,
  borrowers.firstname,
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.phone,
  borrowers.mobile,
  borrowers.phonepro,
  borrowers.B_phone,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateofbirth,
  
  If(Count(DISTINCT issues.issue_id) &gt; 0, "Yes", "No") AS HAS_ITEMS_OUT,
  Count(DISTINCT issues.issue_id) AS CURRENT_CKO_COUNT,
  outstanding.date AS FEE_DATE,
  If(outstanding.accounttype = "L", "Lost Item", If(outstanding.accounttype LIKE "F%", "Fine",
    If(outstanding.accounttype = "A", "Account management fee", If(outstanding.accounttype = "N", "New card",
    If(outstanding.accounttype = "M", "Sundry", If(outstanding.accounttype LIKE "C%", "Copier fees",
    If(outstanding.accounttype LIKE "D%", "Damaged item", "-"))))))) AS TYPE_OF_FEE,
  Format(outstanding.amount, 2) AS FULL_FEE_AMOUNT,
  outstanding.description AS FEE_DESCRIPTION,
  outstanding.note AS FEE_NOTE,
  Format(Sum(outstanding.amount - outstanding.amountoutstanding),2) AS PAID_SO_FAR,
  If(Sum(outstanding.amount &gt; outstanding.amountoutstanding), CAST(outstanding.timestamp AS DATE), "-") AS MOST_RECENT_PAYMENT,
  Format(outstanding.amountoutstanding,2) AS AMOUNT_OUTSTANDING
FROM
    (SELECT
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
      accountlines.manager_id
    FROM
      accountlines
      JOIN borrowers ON borrowers.borrowernumber = accountlines.manager_id
    WHERE
      accountlines.amountoutstanding &gt; 0 AND
      borrowers.branchcode = @brn := &lt;&gt; COLLATE utf8mb4_unicode_ci
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
      accountlines.manager_id
    FROM
      accountlines
      JOIN old_issues ON old_issues.borrowernumber = accountlines.borrowernumber AND old_issues.itemnumber =
        accountlines.itemnumber
    WHERE
      accountlines.amountoutstanding &gt; 0 AND
      old_issues.branchcode = @brn) outstanding
  JOIN borrowers ON borrowers.borrowernumber = outstanding.borrowernumber
  LEFT JOIN issues ON issues.borrowernumber = borrowers.borrowernumber
GROUP BY
  Upper(borrowers.cardnumber),
  outstanding.accountlines_id
HAVING
  HAS_ITEMS_OUT LIKE &lt;&gt;
ORDER BY
  borrowers.surname,
  borrowers.firstname,
  borrowers.cardnumber

























