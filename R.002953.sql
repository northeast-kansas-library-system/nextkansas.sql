/*
R.002953

----------

Name: GHW - Monthly statistics 002
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2017-06-05 14:19:27
Modified on: 2017-06-05 14:41:42
Date last run: 2021-09-03 09:04:59

----------

Public: 0
Expiry: 300

----------

Adult checkouts and renewals last month

----------
*/

SELECT
  branches.branchcode,
  Coalesce(ADULT.count, 0) AS CR_ADULT_LM
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
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (If(items.location IS NULL AND deleteditems.location IS NULL, NULL, Concat(Coalesce(items.location, ''),
        Coalesce(deleteditems.location, ''))) = 'ADULT' OR
        If(items.location IS NULL AND deleteditems.location IS NULL, NULL, Concat(Coalesce(items.location, ''),
        Coalesce(deleteditems.location, ''))) = 'LVPLADULT' OR
        If(items.location IS NULL AND deleteditems.location IS NULL, NULL, Concat(Coalesce(items.location, ''),
        Coalesce(deleteditems.location, ''))) IS NULL)
    GROUP BY
      statistics.branch) ADULT ON branches.branchcode = ADULT.branch
WHERE
  branches.branchcode LIKE <<Choose library|LBRANCH>>
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



