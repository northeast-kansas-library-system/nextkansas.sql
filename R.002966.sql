/*
R.002966

----------

Name: GHW - Collection agency report 03 - Unique management
Created by: George Williams

----------

Group:  OTTAWA
     -

Created on: 2017-06-27 17:08:37
Modified on: 2024-01-17 11:51:43
Date last run: 2026-01-29 11:09:49

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows patrons that OTTAWA has turned over to their collection agency&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows patrons who currently have collection agency flags on their account.&lt;/li&gt;
&lt;li&gt;regardless of the patron's home library&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber and sort1&lt;/li&gt;
&lt;li&gt;sorted by borrowers name, last name first&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2966&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  Format(Sum(accountlines.amountoutstanding), 2) AS Due
FROM
  accountlines
  LEFT JOIN borrowers ON accountlines.borrowernumber = borrowers.borrowernumber
  LEFT JOIN categories ON borrowers.categorycode = categories.categorycode
  LEFT JOIN (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      authorised_values.category,
      authorised_values.lib
    FROM
      borrower_attributes
      JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'CAOTTAWA' AND
      authorised_values.category = 'COLLAGEN') collagen ON borrowers.borrowernumber = collagen.borrowernumber
WHERE
  collagen.attribute LIKE "OTTA%"
GROUP BY
  borrowers.borrowernumber,
  borrowers.cardnumber
ORDER BY
  borrowers.surname,
  borrowers.firstname

























