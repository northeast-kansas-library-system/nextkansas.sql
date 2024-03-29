/*
R.002866

----------

Name: GHW - YE 2.2a
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly Stats Suite

Created on: 2017-01-01 22:38:29
Modified on: 2017-01-01 22:50:22
Date last run: 2022-01-02 13:18:54

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  branches.branchcode AS BRANCH,
  Coalesce(TOTAL_PATRONS.COUNT, 0) AS '2.2a_TOTAL_PATRONS'
FROM
  branches LEFT JOIN
  (SELECT
    borrowers.branchcode,
    Count(*) AS COUNT
  FROM
    borrowers
  GROUP BY
    borrowers.branchcode) TOTAL_PATRONS
    ON branches.branchcode = TOTAL_PATRONS.branchcode
GROUP BY
  branches.branchcode


























