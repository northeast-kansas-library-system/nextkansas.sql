/*
R.003243

----------

Name: GHW - Patron Purge 103
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-02 23:23:38
Modified on: 2020-03-06 14:15:23
Date last run: 2020-03-06 14:23:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Part 3 of the patron purge process - part 3 - change extended attribute to 5-16 as appropriate based on PROJECTED_DELETION date</p>
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3243">Click here to download as a csv file</a></p>
</div>

----------
*/

SELECT
  Concat('<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '" target="_blank">Link to patron</a>') AS LINK_TO_PATRON,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  If((AddDate(Last_Day(SubDate(borrowers.dateexpiry, INTERVAL -37 MONTH)), 1) + INTERVAL 14 DAY) < CAST('2018-04-15' AS DATE), CAST('2018-04-15' AS DATE), (AddDate(Last_Day(SubDate(borrowers.dateexpiry, INTERVAL -37 MONTH)), 1) + INTERVAL 14 DAY)) AS PROJECTED_DELETION,
  Coalesce(accountlinesx.DUE_SUM, 0) AS AMT_DUE,
  Coalesce(issuesx.ICOUNT, 0) AS CHECKOUTS,
  Coalesce(guaranteesx.GCOUNT, 0) AS GUARANTEES,
  Coalesce(requestsx.Count_reserve_id, 0) AS REQUESTS,
  expired_attribute.lib AS ATTRIBUTE,
  Coalesce(expired_attribute.attribute, 0) AS attribute1,
  expired_attribute.code
FROM
  borrowers LEFT JOIN
  (SELECT
      Count(borrowers.borrowernumber) AS GCOUNT,
      borrowers.guarantorid
    FROM
      borrowers
    GROUP BY
      borrowers.guarantorid) guaranteesx ON borrowers.borrowernumber = guaranteesx.guarantorid LEFT JOIN
  (SELECT
      accountlines.borrowernumber,
      Format(Sum(accountlines.amountoutstanding), 2) AS DUE_SUM
    FROM
      accountlines
    GROUP BY
      accountlines.borrowernumber) accountlinesx ON borrowers.borrowernumber = accountlinesx.borrowernumber LEFT JOIN
  (SELECT
      issues.borrowernumber,
      Count(issues.issue_id) AS ICOUNT
    FROM
      issues
    GROUP BY
      issues.borrowernumber) issuesx ON borrowers.borrowernumber = issuesx.borrowernumber LEFT JOIN
  (SELECT
      reserves.borrowernumber,
      Count(reserves.reserve_id) AS Count_reserve_id
    FROM
      reserves
    GROUP BY
      reserves.borrowernumber) requestsx ON borrowers.borrowernumber = requestsx.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      authorised_values.lib,
      authorised_values.category
    FROM
      borrower_attributes JOIN
      authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'expired' AND
      authorised_values.category = 'expired') expired_attribute ON borrowers.borrowernumber = expired_attribute.borrowernumber
WHERE
  borrowers.dateexpiry < CurDate() - INTERVAL 3 YEAR AND
  borrowers.branchcode LIKE '%' AND
  borrowers.othernames NOT LIKE "%SIP%" AND
  borrowers.categorycode <> 'STAFF' AND
  borrowers.categorycode <> 'ILL' AND
  borrowers.categorycode <> 'HOOPLA' AND
  Coalesce(accountlinesx.DUE_SUM, 0) = 0 AND
  Coalesce(issuesx.ICOUNT, 0) = 0 AND
  Coalesce(guaranteesx.GCOUNT, 0) = 0 AND
  Coalesce(requestsx.Count_reserve_id, 0) = 0 AND
  Coalesce(expired_attribute.attribute, 0) < 5
GROUP BY
  borrowers.borrowernumber,
  Coalesce(expired_attribute.attribute, 0),
  expired_attribute.code
ORDER BY
  borrowers.dateexpiry,
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.borrowernumber



