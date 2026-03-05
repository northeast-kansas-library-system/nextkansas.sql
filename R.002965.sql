/*
R.002965

----------

Name: GHW - Collection agency report 02 - Unique management
Created by: George Williams

----------

Group:  OTTAWA
     -

Created on: 2017-06-27 16:45:08
Modified on: 2024-01-17 11:51:40
Date last run: 2026-01-29 11:20:45

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a report of newly delinquent patrons for OTTAWA to send to Unique Management for collections.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows patrons who owe money to OTTAWA and were initially billed more than 60 days ago but less than 1 year ago.&lt;/li&gt;
&lt;li&gt;Shows whose accounts were just turned over to collections and now need their accounts flagged and need the collection fee added to their accounts&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by borrowers name, last name first&lt;/li&gt;
&lt;li&gt;links&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2965&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat('', Upper(borrowers.cardnumber), '') AS "MANUAL_INVOICE",
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
      accountlines.amountoutstanding &gt; 0 AND
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
      accountlines.amountoutstanding &gt; 0 AND
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
  AMOUNT_OUTSTANDING &gt; 25
ORDER BY
  borrowers.surname,
  borrowers.firstname

























