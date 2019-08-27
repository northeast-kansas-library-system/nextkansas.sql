/*
R.003201

----------

Name: GHW - Whose stuff checked out at our library
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-05-07 16:10:27
Modified on: 2019-05-07 16:45:02
Date last run: 2019-08-03 00:11:31

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  If(someone_elses_stuff_our_lib.CKO_BRANCH IS NULL, "-", someone_elses_stuff_our_lib.CKO_BRANCH) AS CKO_BRANCH,
  cko_branch.branchcode AS OWNING_LIB,
  someone_elses_stuff_our_lib.CKO_RENEW AS CKO_RENEW_COUNT
FROM
  (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) cko_branch
  LEFT JOIN (
    SELECT
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS CKO_BRANCH,
      Count(*) AS CKO_RENEW,
      If(Coalesce(items.homebranch, deleteditems.homebranch) IS NULL, "NEKLS", Coalesce(items.homebranch, deleteditems.homebranch)) AS OWNING_BRANCH
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
      If(statistics.branch IS NULL, "NEKLS", statistics.branch) = <<Select your library|branches>>
    GROUP BY
      If(statistics.branch IS NULL, "NEKLS", statistics.branch),
      If(Coalesce(items.homebranch, deleteditems.homebranch) IS NULL, "NEKLS", Coalesce(items.homebranch, deleteditems.homebranch))
  ) someone_elses_stuff_our_lib
    ON someone_elses_stuff_our_lib.OWNING_BRANCH = cko_branch.branchcode
GROUP BY
  cko_branch.branchcode,
  someone_elses_stuff_our_lib.CKO_BRANCH
ORDER BY
  OWNING_LIB



