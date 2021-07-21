/*
R.003482

----------

Name: GHW - Phantom restrictions ADMINREPORT
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2021-03-10 14:54:38
Modified on: 2021-03-14 16:35:21
Date last run: 2021-07-20 08:46:40

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Searches for phantom restrictions</p>
<ul><li>Searches for current instances where data exists in borrowers.debarred but there is no corresponding entry in borrower_debarments.</li>
<li>grouped and sorted by borrowernumber</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Run once a week to identify borrowers with phantom restrictions.  Then use the batch patron editor to remove all restrictions from the accounts.</p>
<p></p>
<p><a href="https://northeast-kansas-library-system.github.io/next/bugs/phantom_restrictions.html"   target="_blank">Training on this report</a></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3482&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">borrowers restrictions</p>
</div>

----------
*/

SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.debarred,
  borrowers.debarredcomment,
  borrower_debarments.borrower_debarment_id
FROM
  borrowers LEFT JOIN
  borrower_debarments ON borrower_debarments.borrowernumber =
      borrowers.borrowernumber
WHERE
  borrowers.debarred IS NOT NULL AND
  borrower_debarments.borrower_debarment_id IS NULL
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.borrowernumber



