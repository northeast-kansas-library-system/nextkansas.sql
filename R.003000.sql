/*
R.003000

----------

Name: GHW - Expired patrons 005 - patrons by expired attribute
Created by: George H Williams

----------

Group: Patrons
     Patron attributes

Created on: 2017-09-18 10:49:25
Modified on: 2019-07-24 17:47:51
Date last run: 2019-07-26 15:02:20

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
  borrowers.surname,
  borrowers.firstname,
  borrowers.othernames,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  If((AddDate(Last_Day(SubDate(borrowers.dateexpiry, INTERVAL -37 MONTH)), 1) + INTERVAL 14 DAY) < CAST('2018-04-15' AS
  DATE), CAST('2018-04-15' AS DATE), (AddDate(Last_Day(SubDate(borrowers.dateexpiry, INTERVAL -37 MONTH)), 1) + INTERVAL
  14 DAY)) AS PROJECTED_DELETION,
  Coalesce(accountlinesx.DUE_SUM, 0) AS AMT_DUE,
  Coalesce(issuesx.ICOUNT, 0) AS CHECKOUTS,
  Coalesce(guarantees.GCOUNT, 0) AS GUARANTEES,
  authorised_values.lib
FROM
  borrowers
  LEFT JOIN (SELECT
        Count(borrowers.borrowernumber) AS GCOUNT,
        borrowers.guarantorid
      FROM
        borrowers
      GROUP BY
        borrowers.guarantorid) guarantees ON borrowers.borrowernumber = guarantees.guarantorid
  LEFT JOIN (SELECT
        accountlines.borrowernumber,
        Format(Sum(accountlines.amountoutstanding), 2) AS DUE_SUM
      FROM
        accountlines
      GROUP BY
        accountlines.borrowernumber) accountlinesx ON borrowers.borrowernumber = accountlinesx.borrowernumber
  LEFT JOIN (SELECT
        issues.borrowernumber,
        Count(issues.issue_id) AS ICOUNT
      FROM
        issues
      GROUP BY
        issues.borrowernumber) issuesx ON borrowers.borrowernumber = issuesx.borrowernumber
  LEFT JOIN borrower_attributes ON borrower_attributes.borrowernumber = borrowers.borrowernumber
  INNER JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
WHERE
  borrowers.branchcode LIKE <<Choose your library|LBRANCH>> AND
  authorised_values.authorised_value LIKE <<Choose expiration notice|LEXPIRED>> AND
  authorised_values.category = 'EXPIRED'
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.borrowernumber



