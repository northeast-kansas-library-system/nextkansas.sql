/*
R.003630

----------

Name: GHW - Non-BONNERSPGS patrons with BONNERSPGS Kanopy access 
Created by: George H Williams

----------

Group:  BONNERSPGS
     -

Created on: 2021-12-21 20:25:19
Modified on: 2021-12-21 20:25:19
Date last run: 2022-07-08 19:45:15

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Shows patrons with a "Kanopy (BONNERSPGS): Allowed . . ." patron attribute but without a BONNERSPGS homebranch</p>
<ul><li>Shows borrwoers that currently have this attribute</li>
<li>grouped by categorycode and borrowernumber</li>
<li>sorted by library card number</li>
<li>links to the borrower account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Should be run monthly at BONNERSPGS so the attribute can be removed from those accounts</p>
<p><a href="https://northeast-kansas-library-system.github.io/next/branches/BONNERSPGS/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank">Go to the training information for the Kanopy (BONNERSPGS) extended borrower attribute.</a></p>
<p></p>
<p class= "notetags" style="display: none;">kanopy; patron-extended-attributes; BASEHOR;</p>
</div>

----------
*/



SELECT
  Concat(
    '<a href="/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=', 
    borrowers.borrowernumber, 
    '&step=4" target="_blank">Go to patron account</a>'
  ) AS LINK,
  borrowers.cardnumber
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
  borrowers.branchcode <> 'BONNERSPGS' AND
  kanopy.attribute = 'BONNERSPGS' AND
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























