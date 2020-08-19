/*
R.003184

----------

Name: GHW - Net borrowers
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2019-03-12 00:46:57
Modified on: 2019-07-01 16:06:44
Date last run: 2020-07-21 13:46:36

----------

Public: 0
Expiry: 300

----------

<p style="display: none;">MNTHLY</p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3184">Click here to download as a csv file</a></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3184&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(not_ours_at_ours.COUNT, 0) AS NOT_OUR_STUFF_AT_OUR_LIBRARY,
  Coalesce(ours_at_other_libraries.COUNT, 0) AS OUR_SUFF_AT_OTHER_LIBRARIES,
  coalesce(not_ours_at_ours.COUNT, 0) - coalesce(ours_at_other_libraries.COUNT, 0) AS NET,
  If(coalesce(not_ours_at_ours.COUNT, 0) - coalesce(ours_at_other_libraries.COUNT, 0) > 0, "Net borrower", "") AS NET_BORROWER,
  If(coalesce(not_ours_at_ours.COUNT, 0) - coalesce(ours_at_other_libraries.COUNT, 0) < 0, "Net lender", "") AS NET_LENDER,
  Concat(Format(Coalesce(not_ours_at_ours.COUNT, 0)/Coalesce(ours_at_other_libraries.COUNT, 0), 2), " : 1")AS BORROWED_TO_LENT_RATIO
FROM
  branches
  LEFT JOIN (SELECT
      statistics.branch,
      Count(*) AS COUNT
    FROM
      statistics
      LEFT JOIN items ON items.itemnumber = statistics.itemnumber
      LEFT JOIN deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      statistics.branch NOT LIKE If(Coalesce(items.homebranch, deleteditems.homebranch) LIKE "DONI%", "DONI%",
      If(Coalesce(items.homebranch, deleteditems.homebranch) LIKE "PH%", "PH%", Coalesce(items.homebranch,
      deleteditems.homebranch)))
    GROUP BY
      statistics.branch) not_ours_at_ours ON not_ours_at_ours.branch = branches.branchcode
  LEFT JOIN (SELECT
      Coalesce(items.homebranch, deleteditems.homebranch) AS branch,
      Count(*) AS COUNT
    FROM
      statistics
      LEFT JOIN items ON items.itemnumber = statistics.itemnumber
      LEFT JOIN deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Coalesce(items.homebranch, deleteditems.homebranch) NOT LIKE If(statistics.branch LIKE "DONI%", "DONI%",
      If(statistics.branch LIKE "PH%", "PH%", statistics.branch))
    GROUP BY
      Coalesce(items.homebranch, deleteditems.homebranch)) ours_at_other_libraries ON ours_at_other_libraries.branch =
    branches.branchcode



