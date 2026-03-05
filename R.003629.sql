/*
R.003629

----------

Name: GHW - BONNERSPGS patrons without Kanopy access
Created by: George Williams

----------

Group:  BONNERSPGS
     -

Created on: 2021-12-21 20:25:13
Modified on: 2025-04-04 15:51:00
Date last run: 2026-01-05 09:33:23

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Shows patrons with a BONNERSPGS home library but without a "Kanopy (BONNERSPGS): Allowed . . ." borrower attribute.</p>
<ul><li>Shows borrwoers that currently lack this attribute</li>
<li>grouped by categorycode and borrowernumber</li>
<li>sorted by library card number</li>
<li>links to the borrower account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Should be run monthly at BONNERSPGS so the attribute can be added to those accounts</p>
<p><a href="https://northeast-kansas-library-system.github.io/next/branches/BONNERSPGS/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank">Go to the training information for the Kanopy (BONNERSPGS) extended borrower attribute.</a></p>
<p></p>
<p class= "notetags" style="display: none;">kanopy; patron-extended-attributes; BONNERSPGS;</p>
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
      borrower_attributes.code = 'BONKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode = 'BONNERSPGS' AND
  kanopy.attribute IS NULL AND
  borrowers.categorycode <> 'STAFF' AND
  borrowers.categorycode <> "ILL" AND
  borrowers.categorycode <> "INHOUSE" AND
  borrowers.categorycode <> "STATISTIC" AND
  borrowers.categorycode <> "S_SIP" AND 
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























