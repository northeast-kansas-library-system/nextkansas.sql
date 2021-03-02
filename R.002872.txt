/*
R.002872

----------

Name: GHW - YE 11.5 and 11.9
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly Stats Suite

Created on: 2017-01-01 22:59:18
Modified on: 2019-01-08 15:35:01
Date last run: 2021-01-14 14:49:21

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  branches.branchcode AS BRANCH,
  Coalesce(NEXPRESS_ILLS_BORROWED.count, 0) AS NX_ILLS_BORROWED,
  Coalesce(NEXPRESS_ILLS_LOANED.count, 0) AS NX_ILLS_LOANED
FROM
  branches LEFT JOIN
  (SELECT
    items.homebranch,
    count(*) AS count
  FROM
    branchtransfers LEFT JOIN
    items
      ON branchtransfers.itemnumber = items.itemnumber
  WHERE
    (items.homebranch != branchtransfers.tobranch) AND
    branchtransfers.frombranch != branchtransfers.tobranch AND
    Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 YEAR)
  GROUP BY
    items.homebranch) NEXPRESS_ILLS_LOANED
    ON branches.branchcode = NEXPRESS_ILLS_LOANED.homebranch LEFT JOIN
  (SELECT
    branchtransfers.tobranch,
    count(*) AS count
  FROM
    branchtransfers LEFT JOIN
    items
      ON branchtransfers.itemnumber = items.itemnumber
  WHERE
    (branchtransfers.tobranch != items.homebranch) AND
    branchtransfers.tobranch != branchtransfers.frombranch AND
    Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 YEAR)
  GROUP BY
    branchtransfers.tobranch) NEXPRESS_ILLS_BORROWED
    ON branches.branchcode = NEXPRESS_ILLS_BORROWED.tobranch
GROUP BY
  branches.branchcode



