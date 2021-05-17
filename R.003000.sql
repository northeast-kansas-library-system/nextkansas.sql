/*
R.003000

----------

Name: GHW - Expired patrons 005 - patrons by expired attribute
Created by: George H Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2017-09-18 10:49:25
Modified on: 2021-04-20 19:17:10
Date last run: 2021-05-13 11:02:39

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Lists patrons based on Account Expiration attributes.</p>
<ul><li>Shows patrons who currently have an Account Expiration attribute set</li>
<li>at the library you specify</li>
<li>grouped by borrower number</li>
<li>sorted by branchcode, patron name, and borrower number</li>
<li>contains links to borrower accounts</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3000&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat('<a href="https://staff.nexpresslibrary.org/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '" target="_blank">Link to patron</a>') AS LINK_TO_PATRON,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  If((AddDate(Last_Day(SubDate(borrowers.dateexpiry, INTERVAL -37 MONTH)), 1) +
  INTERVAL 14 DAY) < CAST('2018-04-15' AS DATE), CAST('2018-04-15' AS DATE),
  (AddDate(Last_Day(SubDate(borrowers.dateexpiry, INTERVAL -37 MONTH)), 1) +
  INTERVAL 14 DAY)) AS PROJECTED_DELETION,
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
  borrowers.branchcode LIKE <<Choose your library|LBRANCH>> AND
  borrowers.othernames NOT LIKE "%SIP%" AND
  borrowers.categorycode <> 'STAFF' AND
  borrowers.categorycode <> 'ILL' AND
  borrowers.categorycode <> 'HOOPLA' AND
  expired_attribute.attribute LIKE <<Choose expiration notice|LEXPIRED>>
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.dateexpiry,
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.borrowernumber



