/*
R.003242

----------

Name: GHW - Patron Purge 102
Created by: George Williams

----------

Group: -
     -

Created on: 2019-08-02 23:13:23
Modified on: 2024-01-17 12:08:42
Date last run: 2026-01-28 16:33:42

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Part 2 of the patron purge process - part 2 - change extended attribute to 2 ("Account expired for more than 2 years - cannot be deleted due to fines/fees/ouverdues/etc.")&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;#PP02 #patron_purge&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat(
    'Link to patron'
  ) AS LINK_TO_PATRON,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  If(
    Day(Now()) &gt;= 15, 
    Date_Format(Now() + INTERVAL 15 MONTH, '%Y-%m-15'),
    Date_Format(Now() + INTERVAL 14 MONTH, '%Y-%m-15')
  ) AS PROJECTED_DELETION,
  Coalesce(accountlinesx.DUE_SUM, 0) AS AMT_DUE,
  Coalesce(issuesx.ICOUNT, 0) AS CHECKOUTS,
  Coalesce(guaranteesx.GCOUNT, 0) AS GUARANTEES,
  Coalesce(requestsx.Count_reserve_id, 0) AS REQUESTS,
  Coalesce(expired_attribute.attribute, 0) AS ATTRIBUTE_VALUE,
  expired_attribute.lib AS ATTRIBUTE
FROM
  borrowers LEFT JOIN
  (SELECT
      accountlines.borrowernumber,
      Format(Sum(accountlines.amountoutstanding), 2) AS DUE_SUM
    FROM
      accountlines
    GROUP BY
      accountlines.borrowernumber) accountlinesx ON borrowers.borrowernumber =
      accountlinesx.borrowernumber LEFT JOIN
  (SELECT
      issues.borrowernumber,
      Count(issues.issue_id) AS ICOUNT
    FROM
      issues
    GROUP BY
      issues.borrowernumber) issuesx ON borrowers.borrowernumber =
      issuesx.borrowernumber LEFT JOIN
  (SELECT
      reserves.borrowernumber,
      Count(reserves.reserve_id) AS Count_reserve_id
    FROM
      reserves
    GROUP BY
      reserves.borrowernumber) requestsx ON borrowers.borrowernumber =
      requestsx.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      authorised_values.lib,
      authorised_values.category
    FROM
      borrower_attributes JOIN
      authorised_values ON borrower_attributes.attribute =
          authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'expired' AND
      authorised_values.category = 'expired') expired_attribute ON
      borrowers.borrowernumber = expired_attribute.borrowernumber LEFT JOIN
  (SELECT
      borrower_relationships.guarantor_id,
      Count(borrower_relationships.guarantee_id) AS GCOUNT
    FROM
      borrower_relationships
    GROUP BY
      borrower_relationships.guarantor_id) guaranteesx ON
      guaranteesx.guarantor_id = borrowers.borrowernumber
WHERE
  borrowers.dateexpiry BETWEEN CurDate() - INTERVAL 1095 DAY AND CurDate() -
  INTERVAL 730.5 DAY AND
  borrowers.branchcode LIKE '%' AND
  Coalesce(borrowers.othernames, "0") NOT LIKE "%SIP%" AND
  borrowers.categorycode &lt;&gt; 'STAFF' AND
  borrowers.categorycode &lt;&gt; 'ILL' AND
  borrowers.categorycode &lt;&gt; 'HOOPLA' AND
  (Coalesce(accountlinesx.DUE_SUM, 0) &lt;&gt; 0 OR
      Coalesce(issuesx.ICOUNT, 0) &lt;&gt; 0 OR
      Coalesce(guaranteesx.GCOUNT, 0) &lt;&gt; 0 OR
      Coalesce(requestsx.Count_reserve_id, 0) &lt;&gt; 0) AND
  Coalesce(expired_attribute.attribute, 0) &lt;&gt; 2
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.dateexpiry,
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.borrowernumber

























