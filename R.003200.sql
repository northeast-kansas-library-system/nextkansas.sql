/*
R.003200

----------

Name: GHW - G3 Sharing statistics - Ours/not ours
Created by: George H Williams

----------

Group: Statistics
     2023 beginning of month statistics

Created on: 2019-05-07 14:47:46
Modified on: 2023-03-15 12:13:25
Date last run: 2023-05-01 01:45:02

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Counts checkouts and renewals at a library during the previous calendar month based on whether the items circulated were owned by the check-out library or owned by a different library</p>
<ul><li>Counts circulation and renewals in the previous calendar month</li>
<li>at all libraries</li>
<li>grouped and sorted by checkout branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Items that appear in the statistics table without a checkout branch are counted as NEKLS checkouts.</p>
<p>Items where the owning library cannot be determined will be counted as being owned by NEKLS.</p>
<p>All items owned by Doniphan County Library District are considered Doniphan County Library District items at all of their libraries - i.e. a DONITROY item checked out at DONIELWD counts as a DONIELWD item.</p>
<p>All items owned by Prairie Hills School District are considered Prairie Hills School District items at all of their libraries - i.e. a PHWAC item checked out at PHSHS counts as a PHSHS item.</p>
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3200">Click here to download as a csv file</a></p>
</div>

----------
*/



SELECT
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
      ) <> If(
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

























