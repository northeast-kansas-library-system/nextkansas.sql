/*
R.003183

----------

Name: GHW - LOCAL 6
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-03-12 00:43:27
Modified on: 2019-03-14 18:09:15
Date last run: 2019-05-13 23:40:21

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchcode,
  CKO_RENEW_TOTAL.COUNT AS CKO_REN_TOTAL,
  CKO_RENEW_LOCAL.COUNT AS CKO_REN_LOCAL,
  CKO_RENEW_LOCAL_UNIQUE_ALL.COUNT AS CKO_REN_LOCAL_UNIQUE,
  CKO_RENEW_LOCAL_6.COUNT AS CKO_REN_LOCAL_6,
  CKO_RENEW_LOCAL_UNIQUE_6.COUNT AS CKO_REN_LOCAL_UNIQUE_6,
  CKO_RENEW_LOCAL_3.COUNT AS CKO_REN_LOCAL_3,
  CKO_RENEW_LOCAL_UNIQUE_3.COUNT AS CKO_REN_LOCAL_UNIQUE_3
FROM
  branches
  LEFT JOIN (
    SELECT
      statistics.branch,
      Count(*) AS COUNT
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      statistics.branch
  ) CKO_RENEW_TOTAL
    ON CKO_RENEW_TOTAL.branch = branches.branchcode
  LEFT JOIN (
    SELECT
      statistics.branch,
      Count(*) AS COUNT
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
      Coalesce(items.homebranch, deleteditems.homebranch)
        LIKE
          If(
            Left(statistics.branch, 4) = 'DONI', 'DONI%',
            If(
              Left(statistics.branch, 2) = 'PH', 'PH%',
              statistics.branch
            )
          )
    GROUP BY
      statistics.branch
  ) CKO_RENEW_LOCAL
    ON CKO_RENEW_LOCAL.branch = branches.branchcode
  LEFT JOIN (
    SELECT
      statistics.branch,
      Count(*) AS COUNT
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
      Coalesce(items.homebranch, deleteditems.homebranch)
        LIKE
          If(
            Left(statistics.branch, 4) = 'DONI', 'DONI%',
            If(
              Left(statistics.branch, 2) = 'PH', 'PH%',
              statistics.branch
            )
          ) AND
      Coalesce(items.dateaccessioned, deleteditems.dateaccessioned) > AddDate(Last_Day(SubDate(Now(), INTERVAL 5 MONTH)), 1)
    GROUP BY
      statistics.branch
  ) CKO_RENEW_LOCAL_3
    ON CKO_RENEW_LOCAL_3.branch = branches.branchcode
  LEFT JOIN (
    SELECT
      statistics.branch,
      Count(*) AS COUNT
    FROM
      statistics
      LEFT JOIN items
        ON items.itemnumber = statistics.itemnumber
      LEFT JOIN deleteditems
        ON deleteditems.itemnumber = statistics.itemnumber
      JOIN (
          SELECT
            items.biblionumber,
            Count(
              If(items.homebranch LIKE "DONI%", "DONI",
                If(items.homebranch LIKE "PH%", "PHSD",
                  items.homebranch
                )
              )
            ) AS Count_homebranch
          FROM
            items
          WHERE
            items.dateaccessioned > AddDate(Last_Day(SubDate(Now(), INTERVAL 5 MONTH)), 1) AND
            items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
          GROUP BY
            items.biblionumber
          HAVING
            Count(
              If(items.homebranch LIKE "DONI%", "DONI",
                If(items.homebranch LIKE "PH%", "PHSD",
                  items.homebranch
                )
              )
            ) = 1
        ) UNIQUE_ITEMS_3
        ON UNIQUE_ITEMS_3.biblionumber = items.biblionumber
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Coalesce(items.homebranch, deleteditems.homebranch)
        LIKE
          If(
            Left(statistics.branch, 4) = 'DONI', 'DONI%',
            If(
              Left(statistics.branch, 2) = 'PH', 'PH%',
              statistics.branch
            )
          ) AND
      Coalesce(items.dateaccessioned, deleteditems.dateaccessioned) > AddDate(Last_Day(SubDate(Now(), INTERVAL 5 MONTH)), 1)
    GROUP BY
      statistics.branch
  ) CKO_RENEW_LOCAL_UNIQUE_3
    ON CKO_RENEW_LOCAL_UNIQUE_3.branch = branches.branchcode
  LEFT JOIN (
    SELECT
      statistics.branch,
      Count(*) AS COUNT
    FROM
      statistics
      LEFT JOIN items
        ON items.itemnumber = statistics.itemnumber
      LEFT JOIN deleteditems
        ON deleteditems.itemnumber = statistics.itemnumber
      JOIN (
          SELECT
            items.biblionumber,
            Count(
              If(items.homebranch LIKE "DONI%", "DONI",
                If(items.homebranch LIKE "PH%", "PHSD",
                  items.homebranch
                )
              )
            ) AS Count_homebranch
          FROM
            items
          GROUP BY
            items.biblionumber
          HAVING
            Count(
              If(items.homebranch LIKE "DONI%", "DONI",
                If(items.homebranch LIKE "PH%", "PHSD",
                  items.homebranch
                )
              )
            ) = 1
        ) UNIQUE_ALL
        ON UNIQUE_ALL.biblionumber = items.biblionumber
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Coalesce(items.homebranch, deleteditems.homebranch)
        LIKE
          If(
            Left(statistics.branch, 4) = 'DONI', 'DONI%',
            If(
              Left(statistics.branch, 2) = 'PH', 'PH%',
              statistics.branch
            )
          )
    GROUP BY
      statistics.branch
  ) CKO_RENEW_LOCAL_UNIQUE_ALL
    ON CKO_RENEW_LOCAL_UNIQUE_ALL.branch = branches.branchcode
  LEFT JOIN (
    SELECT
      statistics.branch,
      Count(*) AS COUNT
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
      Coalesce(items.homebranch, deleteditems.homebranch)
        LIKE
          If(
            Left(statistics.branch, 4) = 'DONI', 'DONI%',
            If(
              Left(statistics.branch, 2) = 'PH', 'PH%',
              statistics.branch
            )
          ) AND
      Coalesce(items.dateaccessioned, deleteditems.dateaccessioned) > AddDate(Last_Day(SubDate(Now(), INTERVAL 8 MONTH)), 1)
    GROUP BY
      statistics.branch
  ) CKO_RENEW_LOCAL_6
    ON CKO_RENEW_LOCAL_6.branch = branches.branchcode
  LEFT JOIN (
    SELECT
      statistics.branch,
      Count(*) AS COUNT
    FROM
      statistics
      LEFT JOIN items
        ON items.itemnumber = statistics.itemnumber
      LEFT JOIN deleteditems
        ON deleteditems.itemnumber = statistics.itemnumber
      JOIN (
          SELECT
            items.biblionumber,
            Count(
              If(items.homebranch LIKE "DONI%", "DONI",
                If(items.homebranch LIKE "PH%", "PHSD",
                  items.homebranch
                )
              )
            ) AS Count_homebranch
          FROM
            items
          WHERE
            items.dateaccessioned > AddDate(Last_Day(SubDate(Now(), INTERVAL 8 MONTH)), 1) AND
            items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
          GROUP BY
            items.biblionumber
          HAVING
            Count(
              If(items.homebranch LIKE "DONI%", "DONI",
                If(items.homebranch LIKE "PH%", "PHSD",
                  items.homebranch
                )
              )
            ) = 1
        ) UNIQUE_ITEMS_6
        ON UNIQUE_ITEMS_6.biblionumber = items.biblionumber
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Coalesce(items.homebranch, deleteditems.homebranch)
        LIKE
          If(
            Left(statistics.branch, 4) = 'DONI', 'DONI%',
            If(
              Left(statistics.branch, 2) = 'PH', 'PH%',
              statistics.branch
            )
          ) AND
      Coalesce(items.dateaccessioned, deleteditems.dateaccessioned) > AddDate(Last_Day(SubDate(Now(), INTERVAL 8 MONTH)), 1)
    GROUP BY
      statistics.branch
  ) CKO_RENEW_LOCAL_UNIQUE_6
    ON CKO_RENEW_LOCAL_UNIQUE_6.branch = branches.branchcode



