/*
R.002955

----------

Name: GHW - Monthly statistics 004
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2017-06-05 14:24:51
Modified on: 2017-06-05 14:46:56
Date last run: 2020-08-03 14:00:28

----------

Public: 0
Expiry: 300

----------

NExpress ILL Loans

----------
*/

SELECT
  branches.branchcode,
  Coalesce(ILL_LOANED.count, 0) AS NX_ILL_LOANED_LM
FROM
  branches
  LEFT JOIN (SELECT
      items.homebranch,
      COUNT(*) AS count
    FROM
      branchtransfers
      LEFT JOIN items ON branchtransfers.itemnumber = items.itemnumber
    WHERE
      items.homebranch <> branchtransfers.tobranch AND
      Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND
      branchtransfers.tobranch <> branchtransfers.frombranch AND
      branchtransfers.comments IS NULL
    GROUP BY
      items.homebranch) ILL_LOANED ON branches.branchcode = ILL_LOANED.homebranch
WHERE
  branches.branchcode LIKE <<Choose library|LBRANCH>>
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



