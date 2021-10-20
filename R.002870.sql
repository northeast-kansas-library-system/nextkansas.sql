/*
R.002870

----------

Name: GHW - YE 11.1 
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly Stats Suite

Created on: 2017-01-01 22:51:24
Modified on: 2020-12-31 15:46:42
Date last run: 2021-01-01 01:05:02

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  branches.branchcode AS BRANCH,
  Coalesce(ADULT_C.COUNT, 0) AS '11.1_ADULT_C'
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
      ((Coalesce(deleteditems.permanent_location, deleteditems.location) = 'ADULT') OR
          (Coalesce(items.permanent_location, items.location) = 'ADULT'))
    GROUP BY
      statistics.branch) ADULT_C ON branches.branchcode = ADULT_C.branch
GROUP BY
  branches.branchcode,
  ADULT_C.COUNT

























