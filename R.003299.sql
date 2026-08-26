/*
R.003299

----------

Name: GHW - Non-LEAVENWRTH patrons with LEAVENWRTH Kanopy access
Created by: George Williams

----------

Group:  LEAVENWRTH
     -

Created on: 2020-01-09 15:15:12
Modified on: 2025-04-04 15:55:41
Date last run: 2026-08-06 14:56:00

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Shows patrons with a "Kanopy (LEAVENWRTH): Allowed . . ." patron attribute but without a LEAVENWRTH homebranch</p>
<ul><li>Shows borrwoers that currently have this attribute</li>
<li>grouped by categorycode and borrowernumber</li>
<li>sorted by library card number</li>
<li>links to the borrower account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Should be run monthly at LEAVENWRTH so the attribute can be removed from those accounts</p>
<p><a href="https://northeast-kansas-library-system.github.io/next/branches/LEAVENWRTH/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank">Go to the training information for the Kanopy (LEAVENWRTH) extended borrower attribute.</a></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3299&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">kanopy; patron-extended-attributes;</p>
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
      borrower_attributes.code = 'LEAVKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode <> 'LEAVENWRTH' AND
  kanopy.attribute = 'LEAVENWRTH' AND
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























