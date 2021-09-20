/*
R.003369

----------

Name: GHW - SABETHA patrons without Kanopy access 
Created by: George H Williams

----------

Group:  SABETHA
     -

Created on: 2020-11-13 13:57:14
Modified on: 2021-08-16 13:41:47
Date last run: 2021-08-24 14:15:38

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Shows patrons with a SABETHA home library but without a "Kanopy (SABETHA): Allowed . . ." borrower attribute.</p>
<ul><li>Shows borrwoers that currently lack this attribute</li>
<li>grouped by categorycode and borrowernumber</li>
<li>sorted by library card number</li>
<li>links to the borrower account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Should be run monthly at SABETHA so the attribute can be added to those accounts</p>
<p><a href="https://northeast-kansas-library-system.github.io/next/branches/SABETHA/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank">Go to the training information for the Kanopy (SABETHA) extended borrower attribute.</a></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3369&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">kanopy; patron-extended-attributes; SABETHA;</p>
</div>

----------
*/

SELECT
  Concat('<a href="/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=', borrowers.borrowernumber, '&step=4" target="_blank">Go to patron account</a>') AS LINK,
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
      borrower_attributes.code = 'SABEKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode = 'SABETHA' AND
  kanopy.attribute IS NULL AND
  borrowers.categorycode <> 'STAFF' AND
  borrowers.categorycode <> "ILL" AND
  borrowers.categorycode <> "INHOUSE" AND
  borrowers.categorycode <> "STATISTIC" AND
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber



