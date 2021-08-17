/*
R.003418

----------

Name: GHW - Monthly 110 Monthly statistics master - Items and holdings
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2021-02-04 16:34:33
Modified on: 2021-07-29 17:15:55
Date last run: 2021-08-01 00:05:01

----------

Public: 0
Expiry: 300

----------

Generates Columns D-I of the monthly statistical report

----------
*/

SELECT
  branches.branchcode AS BRANCH,
  Coalesce(Sum(DISTINCT START_ITEMS.count), 0) AS START_I,
  Coalesce(Sum(DISTINCT END_ITEMS.count), 0) AS END_I,
  Coalesce(Sum(DISTINCT ITEMS_ADDED.count), 0) AS ITEMS_ADD_L_M,
  Coalesce(ITEMS_DELETED.count, 0) AS ITEMS_DEL_L_M,
  Coalesce(Sum(DISTINCT TOTAL_HOLDINGS.count), 0) AS TOTAL_HOLDINGS,
  Coalesce(HOLDINGS_ADDED.count, 0) AS HOLD_ADD_L_M,
  Coalesce(HOLDINGS_DELETED.count, 0) AS HOLD_DEL_L_M
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
      ITEMS_DELETED.homebranch LEFT JOIN
  (SELECT
      items.homebranch,
      Count(DISTINCT items.biblionumber) AS count
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
      Count(DISTINCT deleteditems.biblionumber) AS count
    FROM
      deleteditems
    WHERE
      deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1
      MONTH)), 1) AND
      deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1
      MONTH)), 1)
    GROUP BY
      deleteditems.homebranch) TOTAL_HOLDINGS ON branches.branchcode =
      TOTAL_HOLDINGS.homebranch LEFT JOIN
  (SELECT
      items.homebranch,
      Count(DISTINCT items.biblionumber) AS count
    FROM
      biblio JOIN
      items ON items.biblionumber = biblio.biblionumber
    WHERE
      Month(biblio.datecreated) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(biblio.datecreated) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      items.homebranch) HOLDINGS_ADDED ON branches.branchcode =
      HOLDINGS_ADDED.homebranch LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      Count(DISTINCT deleteditems.biblionumber) AS count
    FROM
      deleteditems JOIN
      deletedbiblio ON deletedbiblio.biblionumber = deleteditems.biblionumber
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      deleteditems.homebranch) HOLDINGS_DELETED ON branches.branchcode =
      HOLDINGS_DELETED.homebranch
GROUP BY
  branches.branchcode



