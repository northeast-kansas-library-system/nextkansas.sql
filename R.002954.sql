/*
R.002954

----------

Name: GHW - Monthly statistics 003
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2017-06-05 14:22:17
Modified on: 2017-06-05 14:41:50
Date last run: 2019-11-03 17:47:33

----------

Public: 0
Expiry: 300

----------

Youth checkouts and renewals last month

----------
*/



SELECT
  branches.branchcode,
  Coalesce(YOUTH.count, 0) AS CR_YOUTH_LM
FROM
  branches
  LEFT JOIN (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics
      LEFT JOIN items ON statistics.itemnumber = items.itemnumber
      LEFT JOIN deleteditems ON statistics.itemnumber = deleteditems.itemnumber
    WHERE
      If(items.location IS NULL AND deleteditems.location IS NULL, NULL, Concat(Coalesce(items.location, ''),
      Coalesce(deleteditems.location, ''))) <> 'ADULT' AND
      If(items.location IS NULL AND deleteditems.location IS NULL, NULL, Concat(Coalesce(items.location, ''),
      Coalesce(deleteditems.location, ''))) <> 'LVPLADULT' AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch) YOUTH ON branches.branchcode = YOUTH.branch
WHERE
  branches.branchcode LIKE <<Choose library|LBRANCH>>
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode

























