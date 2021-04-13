/*
R.003421

----------

Name: GHW - Monthly 9904 ILL Loans and borrows
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-04 17:45:36
Modified on: 2021-02-04 17:45:55
Date last run: 2021-04-05 00:21:23

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchcode,
  Coalesce(ILL_LOANED.count, 0) AS NX_ILL_LOANED_LM,
  Coalesce(ILL_BORROWED.count, 0) AS NX_ILL_BORROWED_LM
FROM
  branches LEFT JOIN
  (SELECT
      items.homebranch,
      COUNT(*) AS count
    FROM
      branchtransfers LEFT JOIN
      items ON branchtransfers.itemnumber = items.itemnumber
    WHERE
      items.homebranch <> branchtransfers.tobranch AND
      Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND
      branchtransfers.tobranch <> branchtransfers.frombranch AND
      branchtransfers.comments IS NULL
    GROUP BY
      items.homebranch) ILL_LOANED ON branches.branchcode =
      ILL_LOANED.homebranch LEFT JOIN
  (SELECT
      branchtransfers.tobranch,
      COUNT(*) AS count
    FROM
      branchtransfers LEFT JOIN
      items ON branchtransfers.itemnumber = items.itemnumber
    WHERE
      branchtransfers.tobranch <> items.homebranch AND
      Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND
      branchtransfers.frombranch <> branchtransfers.tobranch AND
      branchtransfers.comments IS NULL
    GROUP BY
      branchtransfers.tobranch) ILL_BORROWED ON branches.branchcode =
      ILL_BORROWED.tobranch
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



