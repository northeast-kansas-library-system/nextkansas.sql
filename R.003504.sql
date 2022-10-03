/*
R.003504

----------

Name: GHW - Borrower count by zipcode
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-05-12 16:55:32
Modified on: 2021-05-12 20:36:04
Date last run: 2022-04-05 13:26:21

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Counts borrowers by zip code</p>
<ul><li>Shows current data</li>
<li>with the home library you specify</li>
<li>grouped and sorted by borrower home library and zip code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3504&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">tag goes here</p>
</div>

----------
*/



SELECT
  borrowers.branchcode,
  LEFT(borrowers.zipcode, 5) as zipcode,
  Count(borrowers.borrowernumber) AS Count_borrowernumber
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE <<Choose a library|LBRANCH>>
GROUP BY
  borrowers.branchcode,
  LEFT(borrowers.zipcode, 5)
ORDER BY
  borrowers.branchcode,
  LEFT(borrowers.zipcode, 5)

























