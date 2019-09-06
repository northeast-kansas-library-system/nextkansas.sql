/*
R.003208

----------

Name: GHW - Policy map report
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-05-29 16:21:54
Modified on: 2019-08-24 00:20:18
Date last run: 2019-08-24 00:20:33

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Creates borrower address report for use in Policy Map</p>
<ul><li>Shows current patron addresses</li>
<li>at the library you select</li>
<li>grouped by borrowernumber</li>
<li>sorted by address</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3208&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  If(Coalesce(Trim(borrowers.address), Trim(borrowers.address2)) LIKE "PO%", borrowers.address2, borrowers.address) AS address,
  If(borrowers.address2 LIKE "PO%", borrowers.address, borrowers.address2) AS address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.sex,
  Floor((DateDiff(CurDate(), borrowers.dateofbirth) / 365.25)) AS AGE,
  Year(borrowers.dateenrolled) AS YEAR_ENROLLED,
  Year(borrowers.dateexpiry) AS YEAR_EXPIRED,
  Year(borrowers.lastseen) AS YEAR_LASTSEEN
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE "LEAV%" #<<Choose your library|ZBRAN>>
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.branchcode,
  borrowers.categorycode
