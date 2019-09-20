/*
R.003208

----------

Name: GHW - Policy map report
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-05-29 16:21:54
Modified on: 2019-09-04 12:28:58
Date last run: 2019-09-18 10:18:22

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
  If(Coalesce(Trim(borrowers.address)) LIKE "PO%", borrowers.address2, borrowers.address) AS address,
  If(Coalesce(Trim(borrowers.address)) LIKE "PO%", borrowers.address, borrowers.address2) AS address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.sex,
  Floor((DateDiff(CurDate(), borrowers.dateofbirth) / 365.25)) AS AGE,
  Year(borrowers.dateenrolled) AS YEAR_ENROLLED,
  Year(borrowers.dateexpiry) AS YEAR_EXPIRED,
  If(Year(borrowers.lastseen) = 0, "", Year(borrowers.lastseen)) AS YEAR_LASTSEEN
FROM
  borrowers
WHERE
  (borrowers.categorycode <> 'ILL' AND
   borrowers.categorycode <> 'STAFF' AND
   borrowers.categorycode <> 'INHOUSE') AND
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  borrowers.cardnumber,
  borrowers.borrowernumber
ORDER BY
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.branchcode,
  borrowers.categorycode



