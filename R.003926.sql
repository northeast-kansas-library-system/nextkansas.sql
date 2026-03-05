/*
R.003926

----------

Name: GHW - Looker Studio 02 - test
Created by: George Williams

----------

Group: -
     -

Created on: 2025-11-12 12:27:44
Modified on: 2025-11-12 22:43:32
Date last run: 2026-03-05 09:30:34

----------

Public: 1
Expiry: 900

----------



----------
*/



SELECT
  branches.branchname AS branchname,
  Coalesce(Sum(DISTINCT START_ITEMS.count), 0) AS START_I,
  Coalesce(Sum(DISTINCT END_ITEMS.count), 0) AS END_I,
  Coalesce(Sum(DISTINCT ITEMS_ADDED.count), 0) AS ITEMS_ADD_L_M,
  Coalesce(ITEMS_DELETED.count, 0) AS ITEMS_DEL_L_M
FROM
  branches LEFT JOIN
  (SELECT
      items.homebranch,
      Count(*) AS count
    FROM
      items
    WHERE
      items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL
      2 MONTH)), 1)
    GROUP BY
      items.homebranch
    UNION
    SELECT
      deleteditems.homebranch,
      Count(*) AS count
    FROM
      deleteditems
    WHERE
      deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 2
      MONTH)), 1) AND
      deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 2
      MONTH)), 1)
    GROUP BY
      deleteditems.homebranch) START_ITEMS ON branches.branchcode =
      START_ITEMS.homebranch LEFT JOIN
  (SELECT
      items.homebranch,
      Count(*) AS count
    FROM
      items
    WHERE
      items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL
      1 MONTH)), 1)
    GROUP BY
      items.homebranch
    UNION
    SELECT
      deleteditems.homebranch,
      Count(*) AS count
    FROM
      deleteditems
    WHERE
      deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1
      MONTH)), 1) AND
      deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1
      MONTH)), 1)
    GROUP BY
      deleteditems.homebranch) END_ITEMS ON branches.branchcode =
      END_ITEMS.homebranch LEFT JOIN
  (SELECT
      items.homebranch,
      Count(*) AS count
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      items.homebranch
    UNION
    SELECT
      deleteditems.homebranch,
      Count(*) AS count
    FROM
      deleteditems
    WHERE
      Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      deleteditems.homebranch) ITEMS_ADDED ON branches.branchcode =
      ITEMS_ADDED.homebranch LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      Count(*) AS count
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      deleteditems.homebranch) ITEMS_DELETED ON branches.branchcode =
      ITEMS_DELETED.homebranch
GROUP BY
  branches.branchname
ORDER BY
  branches.branchname

























