/*
R.003497

----------

Name: GHW - Borrowers expired for more than 730.5 days
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-04-28 14:48:37
Modified on: 2021-06-04 12:22:18
Date last run: 2021-11-17 14:02:24

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Lists borrower accounts that have been expired for more than 730.5 days (2 years) and includes any account expiration flags</p>
<ul><li>Shows accounts that are currently expired</li>
<li>at the home library you specify</li>
<li>grouped by borrowernumber</li>
<li>sorted by expiration, borrower home library, and borrower number</li>
<li>links to the borrower account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Replaces report 2495</p>
<p></p>
<p>Does not include STAFF, Hoopla, or SIP accounts.</p>
<p></p>
<p class= "notetags" style="display: none;">#expired borrowers</p>
</div>

----------
*/



SELECT
  Concat(
    '<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    borrowers.borrowernumber, 
    '" target="_blank">Link to patron</a>'
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
  borrowers.dateexpiry < CurDate() - INTERVAL 730.5 DAY AND
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>> AND
  borrowers.othernames NOT LIKE "%SIP%" AND
  borrowers.categorycode <> 'STAFF' AND
  borrowers.categorycode <> 'ILL' AND
  borrowers.categorycode <> 'HOOPLA'
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.dateexpiry,
  borrowers.branchcode,
  borrowers.borrowernumber

























