/*
R.003280

----------

Name: GHW - Borrower county by library / city / state
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-11-08 14:37:15
Modified on: 2019-11-08 15:57:10
Date last run: 2021-12-14 15:22:08

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Counts borrowers by homebranch and city/state</p>
<ul><li>counts patrons currently in the system</li>
<li>at the library you specify, at the group of libraries you specify, or at all libraries</li>
<li>grouped by borrower home library, borrower city, and borrower state</li>
<li>sorted by home library, city, and state</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3280&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  information1.HOMEBRANCH,
  information1.city,
  information1.state,
  borrowers_total.Count_borrowernumber AS BORROWERS_TOTAL,
  borrowers_unepired.Count_borrowernumber AS BORROWERS_UNEXPIRED,
  If((borrowers_total.Count_borrowernumber - borrowers_unepired.Count_borrowernumber) = 0, "", (borrowers_total.Count_borrowernumber - borrowers_unepired.Count_borrowernumber)) AS BORROWERS_EXPIRED
FROM
  (
    SELECT
      borrowers.branchcode AS HOMEBRANCH,
      borrowers.city,
      borrowers.state
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode,
      borrowers.city,
      borrowers.state
  ) information1
  INNER JOIN (
    SELECT
      borrowers.branchcode AS HOMEBRANCH,
      borrowers.city,
      borrowers.state,
      Count(borrowers.borrowernumber) AS Count_borrowernumber
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode,
      borrowers.city,
      borrowers.state
  ) borrowers_total
    ON borrowers_total.city = information1.city AND
      borrowers_total.state = information1.state AND
      borrowers_total.HOMEBRANCH = information1.HOMEBRANCH
  LEFT JOIN (
    SELECT
      borrowers.branchcode AS HOMEBRANCH,
      borrowers.city,
      borrowers.state,
      Count(borrowers.borrowernumber) AS Count_borrowernumber
    FROM
      borrowers
    WHERE
      borrowers.dateexpiry >= Now()
    GROUP BY
      borrowers.branchcode,
      borrowers.city,
      borrowers.state
  ) borrowers_unepired
    ON borrowers_unepired.city = information1.city AND
      borrowers_unepired.state = information1.state AND
      borrowers_unepired.HOMEBRANCH = information1.HOMEBRANCH
WHERE
  information1.HOMEBRANCH LIKE <<Choose your library|LBRANCH>>
GROUP BY
  information1.HOMEBRANCH,
  information1.city,
  information1.state,
  borrowers_total.Count_borrowernumber,
  borrowers_unepired.Count_borrowernumber

























