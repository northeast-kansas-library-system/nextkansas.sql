/*
R.002965

----------

Name: GHW - Collection agency report 02 - Unique management
Created by: George H Williams

----------

Group:  OTTAWA
     -

Created on: 2017-06-27 16:45:08
Modified on: 2021-08-16 13:44:05
Date last run: 2023-05-19 09:37:41

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a report of newly delinquent patrons for OTTAWA to send to Unique Management for collections.</p>
<ul><li>Shows patrons who owe money to OTTAWA and were initially billed more than 60 days ago but less than 1 year ago.</li>
<li>Shows whose accounts were just turned over to collections and now need their accounts flagged and need the collection fee added to their accounts</li>
<li>grouped by borrowernumber</li>
<li>sorted by borrowers name, last name first</li>
<li>links</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2965&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/members/maninvoice.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">', Upper(borrowers.cardnumber), '</a>') AS "MANUAL_INVOICE",
  Upper(borrowers.cardnumber) AS CARDNUMBER,
  borrowers.borrowernumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.phone,
  borrowers.mobile,
  borrowers.phonepro AS ALT_PHONE_ONE,
  borrowers.B_phone AS ALT_PHONE_TWO,
  borrowers.branchcode,
  If(categories.category_type = "A", "Adult", If(categories.category_type = "C", "Child", If(categories.category_type = "S", "Staff", If(categories.category_type = "I", "Organization", If(categories.category_type = "P", "Professional", If(categories.category_type = "X", "Statistical", "-")))))) AS CATEGORY,
  borrowers.dateofbirth,
  Format(Sum(outstanding.amountoutstanding), 2) AS AMOUNT_OUTSTANDING
FROM
  (SELECT
      accountlines.accountlines_id,
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.description,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.note,
      accountlines.manager_id
    FROM
      accountlines JOIN
      borrowers ON borrowers.borrowernumber = accountlines.manager_id
    WHERE
      accountlines.amountoutstanding > 0 AND
      accountlines.date BETWEEN (Date_Sub(CurDate(), INTERVAL 1 YEAR)) AND (Date_Sub(CurDate(), INTERVAL 60 DAY)) AND
      borrowers.branchcode = @brn := "OTTAWA" COLLATE utf8mb4_unicode_ci
    UNION
    SELECT
      accountlines.accountlines_id,
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.description,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.note,
      accountlines.manager_id
    FROM
      accountlines JOIN
      old_issues ON old_issues.borrowernumber = accountlines.borrowernumber AND
          old_issues.itemnumber = accountlines.itemnumber
    WHERE
      accountlines.amountoutstanding > 0 AND
      old_issues.branchcode = @brn AND
      accountlines.timestamp BETWEEN (Date_Sub(CurDate(), INTERVAL 1 YEAR)) AND (Date_Sub(CurDate(), INTERVAL 60 DAY))) outstanding JOIN
  borrowers ON borrowers.borrowernumber = outstanding.borrowernumber JOIN
  categories ON borrowers.categorycode = categories.categorycode LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      authorised_values.category,
      authorised_values.lib
    FROM
      borrower_attributes JOIN
      authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'CAOTTAWA' AND
      authorised_values.category = 'COLLAGEN') collagen ON borrowers.borrowernumber = collagen.borrowernumber
WHERE
  collagen.attribute IS NULL
GROUP BY
  borrowers.borrowernumber
HAVING
  AMOUNT_OUTSTANDING > 25
ORDER BY
  borrowers.surname,
  borrowers.firstname

























