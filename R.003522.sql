/*
R.003522

----------

Name: GHW - BASEHOR patrons without Kanopy access
Created by: George Williams

----------

Group:  BASEHOR
     -

Created on: 2021-06-14 11:39:47
Modified on: 2025-04-04 15:33:44
Date last run: 2025-09-03 09:10:58

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Shows patrons with a BASEHOR home library but without a "Kanopy (BASEHOR): Allowed . . ." borrower attribute.</p>
<ul><li>Shows borrwoers that currently lack this attribute</li>
<li>grouped by categorycode and borrowernumber</li>
<li>sorted by library card number</li>
<li>links to the borrower account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Should be run monthly at BASEHOR so the attribute can be added to those accounts</p>
<p><a href="https://northeast-kansas-library-system.github.io/next/branches/BASEHOR/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank">Go to the training information for the Kanopy (BASEHOR) extended borrower attribute.</a></p>
<p></p>
<p class= "notetags" style="display: none;">kanopy; patron-extended-attributes; BASEHOR;</p>
</div>

----------
*/



SELECT
  Concat(
    'Go to patron account'
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
      borrower_attributes.code = 'BASEKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode = 'BASEHOR' AND
  kanopy.attribute IS NULL AND
  borrowers.categorycode &lt;&gt; 'STAFF' AND
  borrowers.categorycode &lt;&gt; "ILL" AND
  borrowers.categorycode &lt;&gt; "INHOUSE" AND
  borrowers.categorycode &lt;&gt; "STATISTIC" AND
  borrowers.categorycode &lt;&gt; "S_SIP" AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























