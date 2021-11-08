/*
R.003582

----------

Name: LibraryIQ - Data Validation tab (setup)
Created by: George H Williams

----------

Group: LibraryIQ
     Setup

Created on: 2021-10-11 16:52:07
Modified on: 2021-10-13 11:11:43
Date last run: 2021-10-29 17:22:00

----------

Public: 0
Expiry: 300

----------

#libraryiq #setup

----------
*/



SELECT
  branches.branchname AS Library,
  branches.branchcode AS `Library ID`,
  item_count.Count_itemnumber AS `Total Collection Size`,
  cko_renew_365.cko_renew_count AS `Total Circulation for the most recent 12 months`,
  items_added_365.Sum_Count_itemnumber AS `Additions for the most recent 12 months`,
  items_added_730_365.Sum_Count_itemnumber AS `Previous Year Additions - the preceeding 12 months`,
  borrower_count.Count_borrowernumber AS `Total Patrons`,
  activer_borrower_count.Count_borrowernumber AS `Total Active Patrons (Active -IN KOHA- in the previous 12 months)`,
  CurDate() AS `Report Date`
FROM
  branches JOIN
  (SELECT
      items.homebranch,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch) item_count ON item_count.homebranch =
      branches.branchcode JOIN
  (SELECT
      statistics.branch,
      count(*) AS cko_renew_count
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      statistics.datetime >= CurDate() - INTERVAL 1 YEAR
    GROUP BY
      statistics.branch) cko_renew_365 ON cko_renew_365.branch =
      branches.branchcode JOIN
  (SELECT
      branches.branchcode,
      Sum(icount_365_raw.Count_itemnumber) AS Sum_Count_itemnumber
    FROM
      branches JOIN
      (SELECT
          items.homebranch,
          Count(items.itemnumber) AS Count_itemnumber
        FROM
          items
        WHERE
          items.dateaccessioned >= CurDate() - INTERVAL 1 YEAR
        GROUP BY
          items.homebranch
        UNION
        SELECT
          deleteditems.homebranch,
          Count(deleteditems.itemnumber) AS Count_itemnumber
        FROM
          deleteditems
        WHERE
          deleteditems.dateaccessioned >= CurDate() - INTERVAL 1 YEAR
        GROUP BY
          deleteditems.homebranch) icount_365_raw ON icount_365_raw.homebranch =
          branches.branchcode
    GROUP BY
      branches.branchcode) items_added_365 ON items_added_365.branchcode =
      branches.branchcode JOIN
  (SELECT
      branches.branchcode,
      Sum(icount_730_365_raw.Count_itemnumber) AS Sum_Count_itemnumber
    FROM
      branches JOIN
      (SELECT
          items.homebranch,
          Count(items.itemnumber) AS Count_itemnumber
        FROM
          items
        WHERE
          items.dateaccessioned BETWEEN (CurDate() - INTERVAL 2 YEAR) AND (CurDate() - INTERVAL 1 YEAR)
        GROUP BY
          items.homebranch
        UNION
        SELECT
          deleteditems.homebranch,
          Count(deleteditems.itemnumber) AS Count_itemnumber
        FROM
          deleteditems
        WHERE
          deleteditems.dateaccessioned BETWEEN (CurDate() - INTERVAL 2 YEAR) AND (CurDate() - INTERVAL 1 YEAR)
        GROUP BY
          deleteditems.homebranch) icount_730_365_raw ON
          icount_730_365_raw.homebranch = branches.branchcode
    GROUP BY
      branches.branchcode) items_added_730_365 ON items_added_730_365.branchcode
      = branches.branchcode JOIN
  (SELECT
      borrowers.branchcode,
      Count(borrowers.borrowernumber) AS Count_borrowernumber
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode) borrower_count ON borrower_count.branchcode =
      branches.branchcode JOIN
  (SELECT
      statistics.branch,
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
    FROM
      statistics
    WHERE
      statistics.datetime >= CurDate() - INTERVAL 1 YEAR
    GROUP BY
      statistics.branch) activer_borrower_count ON activer_borrower_count.branch
      = branches.branchcode
WHERE
  branches.branchcode = <<Choose your library|branches>>
GROUP BY
  branches.branchcode

























