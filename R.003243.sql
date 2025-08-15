/*
R.003243

----------

Name: GHW - Patron Purge 103
Created by: George Williams

----------

Group: -
     -

Created on: 2019-08-02 23:23:38
Modified on: 2024-01-17 12:08:45
Date last run: 2025-08-14 08:22:05

----------

Public: 0
Expiry: 300

----------

 
Part 3 of the patron purge process - part 3 - change extended attribute to 5-16 ("Account expired for more than 3 years - scheduled to be auto-deleted on mm.dd") as appropriate based on PROJECTED_DELETION date

#PP03 #patron_purge


----------
*/



SELECT
  Concat(
    'Link to patron'
  ) AS
  LINK_TO_PATRON,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  If(
    Day(Now()) &gt;= 15, 
    Date_Format(Now() + INTERVAL 3 MONTH, '%Y-%m-15'),
    Date_Format(Now() + INTERVAL 2 MONTH, '%Y-%m-15')
  ) AS PROJECTED_DELETION,
  Coalesce(accountlinesx.DUE_SUM, 0) AS AMT_DUE,
  Coalesce(issuesx.ICOUNT, 0) AS CHECKOUTS,
  Coalesce(guaranteesx.GCOUNT, 0) AS GUARANTEES,
  Coalesce(requestsx.Count_reserve_id, 0) AS REQUESTS,
  expired_attribute.lib AS ATTRIBUTE,
  Coalesce(expired_attribute.attribute, 0) AS ATTRIBUTE_VALUE,
  expired_attribute.code AS ATTRIBUTE
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
  borrowers.dateexpiry &lt; CurDate() - INTERVAL 3 YEAR AND
  borrowers.branchcode LIKE '%' AND
  Coalesce(borrowers.othernames, "0") NOT LIKE "%SIP%" AND
  borrowers.categorycode &lt;&gt; 'STAFF' AND
  borrowers.categorycode &lt;&gt; 'ILL' AND
  borrowers.categorycode &lt;&gt; 'HOOPLA' AND
  Coalesce(accountlinesx.DUE_SUM, 0) = 0 AND
  Coalesce(issuesx.ICOUNT, 0) = 0 AND
  Coalesce(guaranteesx.GCOUNT, 0) = 0 AND
  Coalesce(requestsx.Count_reserve_id, 0) = 0 AND
  (Coalesce(expired_attribute.attribute, 0) &lt; 5 OR
    expired_attribute.attribute IS NULL)
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.dateexpiry,
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.borrowernumber

























