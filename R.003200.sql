/*
R.003200

----------

Name: 0130 - 2024_99_g_sharing monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2019-05-07 14:47:46
Modified on: 2025-04-30 11:51:59
Date last run: 2025-08-01 01:30:02

----------

Public: 0
Expiry: 300

----------

 
Counts checkouts and renewals at a library during the previous calendar month based on whether the items circulated were owned by the check-out library or owned by a different library
Counts circulation and renewals in the previous calendar month
at all libraries
grouped and sorted by checkout branchcode

Notes:

Items that appear in the statistics table without a checkout branch are counted as NEKLS checkouts.
Items where the owning library cannot be determined will be counted as being owned by NEKLS.
All items owned by Doniphan County Library District are considered Doniphan County Library District items at all of their libraries - i.e. a DONITROY item checked out at DONIELWD counts as a DONIELWD item.
All items owned by Prairie Hills School District are considered Prairie Hills School District items at all of their libraries - i.e. a PHWAC item checked out at PHSHS counts as a PHSHS item.

Click here to download as a csv file


----------
*/



SELECT 
  'Library' AS 'Library',
  'Items owned by this library checked out at this library this month' AS 'Items owned by this library checked out at this library this month',
  'Items owned by other libraries checked out at this library this month' AS 'Items owned by other libraries checked out at this library this month',
  'Total circulation this month' AS 'Total circulation this month'
UNION 
(SELECT
  branch.branchname AS Library,
  ours_at_ours.CKO_RENEW AS 'Items owned by this library checked out at this library this month',
  notours_at_ours.CKO_RENEW AS 'Items owned by other libraries checked out at this library this month',
  total.CKO_RENEW AS 'Total circulation this month'
FROM
  (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) branch
  LEFT JOIN (
    SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS CKO_BRANCH,
      Count(*) AS CKO_RENEW
    FROM
      statistics
      LEFT JOIN items
        ON items.itemnumber = statistics.itemnumber
      LEFT JOIN deleteditems
        ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(
        Coalesce(items.homebranch, deleteditems.homebranch) LIKE "DONI%",
        "DONI%",
        If(
          Coalesce(items.homebranch, deleteditems.homebranch) LIKE "PH%",
          "PH%",
          If(
            Coalesce(items.homebranch, deleteditems.homebranch) IS NULL,
            "NEKLS",
            Coalesce(items.homebranch, deleteditems.homebranch)
          )
        )
      ) = If(
        statistics.branch IS NULL,
        "NEKLS",
        If(
          statistics.branch LIKE "DONI%",
          "DONI%",
          If(
            statistics.branch LIKE "PH%",
            "PH%",
            statistics.branch
          )
        )
      )
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch)
  ) ours_at_ours
    ON ours_at_ours.CKO_BRANCH = branch.branchcode
  LEFT JOIN (
    SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS CKO_BRANCH,
      Count(*) AS CKO_RENEW
    FROM
      statistics
      LEFT JOIN items
        ON items.itemnumber = statistics.itemnumber
      LEFT JOIN deleteditems
        ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(
        Coalesce(items.homebranch, deleteditems.homebranch) LIKE "DONI%",
        "DONI%",
        If(
          Coalesce(items.homebranch, deleteditems.homebranch) LIKE "PH%",
          "PH%",
          If(
            Coalesce(items.homebranch, deleteditems.homebranch) IS NULL,
            "NEKLS",
            Coalesce(items.homebranch, deleteditems.homebranch)
          )
        )
      ) &lt;&gt; If(
        statistics.branch IS NULL,
        "NEKLS",
        If(
          statistics.branch LIKE "DONI%",
          "DONI%",
          If(
            statistics.branch LIKE "PH%",
            "PH%",
            statistics.branch
          )
        )
      )
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch)
  ) notours_at_ours
    ON notours_at_ours.CKO_BRANCH = branch.branchcode
  LEFT JOIN (
    SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS CKO_BRANCH,
      Count(*) AS CKO_RENEW
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch)
  ) total
    ON total.CKO_BRANCH = branch.branchcode
GROUP BY
  branch.branchname
ORDER BY
  branch.branchname
) 

























