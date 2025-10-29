/*
R.003496

----------

Name: GHW - Non-LANSING patrons with LANSING Kanopy access 
Created by: George Williams

----------

Group:  LANSING
     -

Created on: 2021-04-22 16:55:19
Modified on: 2025-04-04 15:52:20
Date last run: 2025-08-28 11:33:45

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Shows patrons with a "Kanopy (LANSING): Allowed . . ." patron attribute but without a LANSING homebranch</p>
<ul><li>Shows borrwoers that currently have this attribute</li>
<li>grouped by categorycode and borrowernumber</li>
<li>sorted by library card number</li>
<li>links to the borrower account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Should be run monthly at LANSING so the attribute can be removed from those accounts</p>
<p><a href="https://northeast-kansas-library-system.github.io/next/branches/LANSING/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank">Go to the training information for the Kanopy (LANSING) extended borrower attribute.</a></p>
<p></p>
<p class= "notetags" style="display: none;">kanopy; patron-extended-attributes; LANSING;</p>
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
      borrower_attributes.code = 'LANSKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'LANSING' AND
  kanopy.attribute = 'LANSING' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























