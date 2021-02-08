/*
R.002871

----------

Name: GHW - YE 11.2
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly Stats Suite

Created on: 2017-01-01 22:52:08
Modified on: 2020-12-31 15:55:10
Date last run: 2021-01-01 01:10:02

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  branches.branchcode AS BRANCH,
  Coalesce(YOUTH_C.COUNT, 0) AS '11.2_YOUTH_C'
FROM
  branches LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS COUNT
    FROM
      statistics LEFT JOIN
      items ON statistics.itemnumber = items.itemnumber LEFT JOIN
      deleteditems ON statistics.itemnumber = deleteditems.itemnumber
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 YEAR) AND
      (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
      ((Coalesce(deleteditems.permanent_location, deleteditems.location) <> 'ADULT') OR
          (Coalesce(items.permanent_location, items.location) <> 'ADULT'))
    GROUP BY
      statistics.branch) YOUTH_C ON branches.branchcode = YOUTH_C.branch
GROUP BY
  branches.branchcode,
  YOUTH_C.COUNT




