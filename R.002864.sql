/*
R.002864

----------

Name: GHW - Monthly Master Report
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-12-31 18:37:17
Modified on: 2016-12-31 18:37:17
Date last run: 2019-07-15 16:52:42

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchcode AS BRANCH,
  Coalesce(CHECKOUT_RENEW_LOCALUSE.count, 0) AS CIRC_RENEW_LAST_M,
  Coalesce(CARDS_USED.Count_borrowernumber, 0) AS UNIQUE_CARDS_USED_LAST_M,
  Coalesce(TOTAL_ITEMS.count, 0) AS TOTAL_ITEMS,
  Coalesce(ITEMS_ADDED.count, 0) AS ITEMS_ADDED_LAST_M,
  Coalesce(ITEMS_DELETED.count, 0) AS ITEMS_DELETED_LAST_M,
  Coalesce(TOTAL_PATRONS.count, 0) AS TOTAL_PATRONS,
  Coalesce(PATRONS_ADDED.count, 0) AS PATRONS_ADDED_LAST_M,
  Coalesce(PATRONS_DELETED.Count, 0) AS PATRONS_DELETED_LAST_M,
  Coalesce(`NEXPRESS _ILLS_LOANED`.count, 0) AS NEXPRESS_ILLS_LOANED_LAST_M,
  Coalesce(NEXPRESS_ILLS_BORROWED.count, 0) AS NEXPRESS_ILLS_BORROWED_LAST_M
FROM
  branches LEFT JOIN
  (SELECT
    statistics.branch,
    Count(*) AS count
  FROM
    statistics
  WHERE
    (statistics.type = 'issue' OR
      statistics.type = 'renew' OR
      statistics.type = 'localuse') AND
    Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
    Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
  GROUP BY
    statistics.branch) CHECKOUT_RENEW_LOCALUSE
    ON branches.branchcode = CHECKOUT_RENEW_LOCALUSE.branch LEFT JOIN
  (SELECT
    borrowers.branchcode,
    Count(*) AS count
  FROM
    borrowers
  WHERE
    Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND
    Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH)
  GROUP BY
    borrowers.branchcode) PATRONS_ADDED
    ON branches.branchcode = PATRONS_ADDED.branchcode LEFT JOIN
  (SELECT
    items.homebranch,
    Count(*) AS count
  FROM
    items
  GROUP BY
    items.homebranch) TOTAL_ITEMS
    ON branches.branchcode = TOTAL_ITEMS.homebranch LEFT JOIN
  (SELECT
    borrowers.branchcode,
    Count(*) AS count
  FROM
    borrowers
  GROUP BY
    borrowers.branchcode) TOTAL_PATRONS
    ON branches.branchcode = TOTAL_PATRONS.branchcode LEFT JOIN
  (SELECT
    items.homebranch,
    Count(*) AS count
  FROM
    items
  WHERE
    Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
    Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
  GROUP BY
    items.homebranch) ITEMS_ADDED
    ON branches.branchcode = ITEMS_ADDED.homebranch LEFT JOIN
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
    Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND
    Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND
    branchtransfers.comments IS NULL
  GROUP BY
    items.homebranch) `NEXPRESS _ILLS_LOANED`
    ON branches.branchcode = `NEXPRESS _ILLS_LOANED`.homebranch LEFT JOIN
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
    Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND
    Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND
    branchtransfers.comments IS NULL
  GROUP BY
    branchtransfers.tobranch) NEXPRESS_ILLS_BORROWED
    ON branches.branchcode = NEXPRESS_ILLS_BORROWED.tobranch LEFT JOIN
  (SELECT
    deleteditems.homebranch,
    Count(*) AS count
  FROM
    deleteditems
  WHERE
    Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
    Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH)
  GROUP BY
    deleteditems.homebranch) ITEMS_DELETED
    ON branches.branchcode = ITEMS_DELETED.homebranch LEFT JOIN
  (SELECT
    deletedborrowers.branchcode,
    Count(*) AS Count
  FROM
    action_logs JOIN
    deletedborrowers
      ON deletedborrowers.borrowernumber = action_logs.object
  WHERE
    Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
    action_logs.action LIKE 'DELET%'
  GROUP BY
    deletedborrowers.branchcode) PATRONS_DELETED
    ON branches.branchcode = PATRONS_DELETED.branchcode LEFT JOIN
  (SELECT
    statistics.branch,
    Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
  FROM
    statistics
  WHERE
    (statistics.type = 'issue' OR
      statistics.type = 'renew' OR
      statistics.type = 'localuse') AND
    Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
    Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
  GROUP BY
    statistics.branch) CARDS_USED
    ON branches.branchcode = CARDS_USED.branch
GROUP BY
  branches.branchcode



