/*
R.003203

----------

Name: GHW - Test for charts
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-05-12 23:32:25
Modified on: 2019-05-12 23:55:13
Date last run: 2019-09-06 22:04:12

----------

Public: 0
Expiry: 300

----------

Test for charts

----------
*/

SELECT
  branches.branchcode,
  patrons.dateenrolled,
  patrons.Count_borrowernumber
FROM
  branches
  LEFT JOIN (
    SELECT
      Count(borrowers.borrowernumber) AS Count_borrowernumber,
      borrowers.branchcode,
      Year(borrowers.dateenrolled) AS dateenrolled
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode,
      Year(borrowers.dateenrolled)
  ) patrons
    ON patrons.branchcode = branches.branchcode
WHERE
  branches.branchcode = <<Selct library|branches>>
GROUP BY
  branches.branchcode,
  patrons.dateenrolled,
  patrons.Count_borrowernumber



