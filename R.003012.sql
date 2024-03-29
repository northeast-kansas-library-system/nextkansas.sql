/*
R.003012

----------

Name: GHW - Unneeded restrictions
Created by: George H Williams

----------

Group: Borrowers
     Fix Patrons

Created on: 2017-11-15 16:38:41
Modified on: 2019-08-21 23:52:35
Date last run: 2022-09-03 15:31:28

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Shows patrons with a restriction on their account that my no longer be justified</p>
<ul><li>Shows current restrictions</li>
<li>shows patrons based on the home library you select when running the report</li>
<li>grouped by borrowernumber and borrower_debarment_id</li>
<li>sorted by borrower homebranch and date the restriction was created</li>
<li>links</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>There are thousands of restrictions that were added manually on 2014.03.12 in an effort to clear up some database issues.  None of the 2014.03.12 restrictions have any comments or notes explaining the reason for the restriction.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3012&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">Link to patron</a>') AS LINK_TO_PATRON,
  borrowers.cardnumber,
  borrowers.branchcode,
  borrower_debarments.created,
  borrower_debarments.updated,
  borrower_debarments.expiration,
  borrower_debarments.type,
  borrower_debarments.comment,
  Concat('<a href=\"/cgi-bin/koha/members/mod_debarment.pl?borrowernumber=', borrowers.borrowernumber, '&borrower_debarment_id=', borrower_debarment_id 	, '&action=del" target="_blank">Deelte</a>') AS DEELETE
FROM
  borrowers
  LEFT JOIN accountlines ON accountlines.borrowernumber = borrowers.borrowernumber
  LEFT JOIN issues ON issues.borrowernumber = borrowers.borrowernumber
  JOIN borrower_debarments ON borrower_debarments.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose a library|LBRANCH>>
GROUP BY
  borrowers.borrowernumber,
  borrower_debarments.borrower_debarment_id
HAVING
  Sum(accountlines.amountoutstanding) = 0 AND
  Count(issues.issue_id) = 0
ORDER BY
  borrowers.branchcode,
  borrower_debarments.created

























