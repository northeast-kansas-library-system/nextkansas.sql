/*
R.003298

----------

Name: GHW - LEAVENWRTH patrons without Kanopy access
Created by: George Williams

----------

Group:  LEAVENWRTH
     -

Created on: 2020-01-09 15:12:38
Modified on: 2025-04-04 15:55:39
Date last run: 2025-10-23 18:05:36

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Shows patrons with a LEAVENWRTH home library but without a "Kanopy (LEAVENWRTH): Allowed . . ." borrower attribute.</p>
<ul><li>Shows borrwoers that currently lack this attribute</li>
<li>grouped by categorycode and borrowernumber</li>
<li>sorted by library card number</li>
<li>links to the borrower account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Should be run monthly at LEAVENWRTH so the attribute can be added to those accounts</p>
<p><a href="https://northeast-kansas-library-system.github.io/next/branches/LEAVENWRTH/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank">Go to the training information for the Kanopy (LEAVENWRTH) extended borrower attribute.</a></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3298&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">kanopy; patron-extended-attributes; LEAVENWRTH;</p>
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
      borrower_attributes.code = 'LEAVKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode = 'LEAVENWRTH' AND
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

























