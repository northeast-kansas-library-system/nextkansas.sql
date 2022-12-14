/*
R.003244

----------

Name: GHW - Patron Purge 104
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-02 23:34:40
Modified on: 2021-11-10 09:34:24
Date last run: 2022-12-13 10:04:25

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Part 4 of the patron purge process - part 4 - change extended attribute to 4 ("Account expired for more than 3 years - can't be auto-deleted due to problems with the account ")</p>
<p></p>
<p class= "notetags" style="display: none;">#PP04 #patron_purge</p>
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
  If(
    Day(Now()) >= 15, 
    Date_Format(Now() + INTERVAL 3 MONTH, '%Y-%m-15'),
    Date_Format(Now() + INTERVAL 2 MONTH, '%Y-%m-15')
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
      borrower_relationships.guarantor_id,
      Count(borrower_relationships.guarantee_id) AS GCOUNT
    FROM
      borrower_relationships
    GROUP BY
      borrower_relationships.guarantor_id) guaranteesx ON guaranteesx.guarantor_id =
      borrowers.borrowernumber LEFT JOIN
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
      borrowers.borrowernumber = expired_attribute.borrowernumber
WHERE
  borrowers.dateexpiry < CurDate() - INTERVAL 3 YEAR AND
  borrowers.branchcode LIKE '%' AND
  Coalesce(borrowers.othernames, "0") NOT LIKE "%SIP%" AND
  borrowers.categorycode <> 'STAFF' AND
  borrowers.categorycode <> 'ILL' AND
  borrowers.categorycode <> 'HOOPLA'  AND
  Coalesce(expired_attribute.attribute, 0) <> 4 AND
  (Coalesce(accountlinesx.DUE_SUM, 0) <> 0 OR
      Coalesce(issuesx.ICOUNT, 0) <> 0 OR
      Coalesce(guaranteesx.GCOUNT, 0) > 0 OR
      Coalesce(requestsx.Count_reserve_id, 0) <> 0)
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.dateexpiry,
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.borrowernumber

























