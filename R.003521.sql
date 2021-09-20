/*
R.003521

----------

Name: GHW - Non-ATCHISON patrons with ATCHISON Kanopy access 
Created by: George H Williams

----------

Group:  ATCHISON
     -

Created on: 2021-06-14 11:30:27
Modified on: 2021-07-20 13:53:56
Date last run: 2021-08-24 14:11:58

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Shows patrons with a "Kanopy (ATCHISON): Allowed . . ." patron attribute but without a ATCHISON homebranch</p>
<ul><li>Shows borrwowers that currently have this attribute</li>
<li>grouped by categorycode and borrowernumber</li>
<li>sorted by library card number</li>
<li>links to the borrower account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Should be run monthly at ATCHISON so the attribute can be removed from those accounts</p>
<p><a href="https://northeast-kansas-library-system.github.io/next/branches/ATCHISON/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank">Go to the training information for the Kanopy (ATCHISON) extended borrower attribute.</a></p>
<p></p>
<p class= "notetags" style="display: none;">kanopy; patron-extended-attributes; ATCHISON;</p>
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
      borrower_attributes.code = 'ATCHKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode <> 'ATCHISON' AND
  kanopy.attribute = 'ATCHISON' AND
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber



