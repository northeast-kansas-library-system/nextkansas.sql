/*
R.003301

----------

Name: GHW - Non-OTTAWA patrons with OTTAWA Kanopy access
Created by: George Williams

----------

Group:  OTTAWA
     -

Created on: 2020-01-09 15:33:11
Modified on: 2025-04-04 15:55:51
Date last run: 2025-04-04 15:55:51

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Shows patrons with a "Kanopy (OTTAWA): Allowed . . ." patron attribute but without a OTTAWA homebranch</p>
<ul><li>Shows borrwoers that currently have this attribute</li>
<li>grouped by categorycode and borrowernumber</li>
<li>sorted by library card number</li>
<li>links to the borrower account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Should be run monthly at OTTAWA so the attribute can be removed from those accounts</p>
<p><a href="https://northeast-kansas-library-system.github.io/next/branches/OTTAWA/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank">Go to the training information for the Kanopy (OTTAWA) extended borrower attribute.</a></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3301&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">kanopy; patron-extended-attributes; OTTAWA;</p>
</div>

----------
*/



SELECT
  Concat(
    '<a class="next_btn next_yellow noprint" ',
    'href="/cgi-bin/koha/members/moremember.pl?borrowernumber=', 
    borrowers.borrowernumber, 
    '#patron-extended-attributes" ', 
    'target="_blank">Go to patron account</a>'
  ) AS LINK,
  borrowers.cardnumber AS CARD_NUMBER
FROM
  borrowers
  LEFT JOIN (
    SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute
    FROM
      borrower_attributes
    WHERE
      borrower_attributes.code = 'OTTAKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode <> 'OTTAWA' AND
  kanopy.attribute = 'OTTAWA' AND
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























