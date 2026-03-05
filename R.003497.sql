/*
R.003497

----------

Name: GHW - Borrowers expired for more than 730.5 days
Created by: George Williams

----------

Group: -
     -

Created on: 2021-04-28 14:48:37
Modified on: 2024-01-17 11:33:00
Date last run: 2026-01-29 11:55:29

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Lists borrower accounts that have been expired for more than 730.5 days (2 years) and includes any account expiration flags&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows accounts that are currently expired&lt;/li&gt;
&lt;li&gt;at the home library you specify&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by expiration, borrower home library, and borrower number&lt;/li&gt;
&lt;li&gt;links to the borrower account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Replaces report 2495&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Does not include STAFF, Hoopla, or SIP accounts.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;#expired borrowers&lt;/p&gt;
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
  AddDate(Last_Day(SubDate(borrowers.dateexpiry, INTERVAL -37 MONTH)), 1) + INTERVAL 14 DAY AS PROJECTED_DELETION_DATE,
  Coalesce(accountlinesx.DUE_SUM, 0) AS AMT_DUE,
  Coalesce(issuesx.ICOUNT, 0) AS CHECKOUTS,
  Coalesce(guaranteesx.GCOUNT, 0) AS GUARANTEES,
  Coalesce(requestsx.Count_reserve_id, 0) AS REQUESTS,
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
  borrowers.dateexpiry &lt; CurDate() - INTERVAL 730.5 DAY AND
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.othernames NOT LIKE "%SIP%" AND
  borrowers.categorycode &lt;&gt; 'STAFF' AND
  borrowers.categorycode &lt;&gt; 'ILL' AND
  borrowers.categorycode &lt;&gt; 'HOOPLA'
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.dateexpiry,
  borrowers.branchcode,
  borrowers.borrowernumber

























