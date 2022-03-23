/*
R.003184

----------

Name: GHW - Monthly 620 Net borrows
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2019-03-12 00:46:57
Modified on: 2022-03-11 17:12:55
Date last run: 2022-03-11 17:15:02

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
  branches.branchname AS "Library",
  Coalesce(not_ours_at_ours.COUNTS, 0) AS "Other Next library materials checked out at our library",
  Coalesce(ours_at_other_libraries.COUNTS, 0) AS "Our materials checked out at other Next libraries",
  Coalesce(not_ours_at_ours.COUNTS, 0) -  Coalesce(ours_at_other_libraries.COUNTS, 0) AS NET,
  If(Coalesce(not_ours_at_ours.COUNTS, 0) -  Coalesce(ours_at_other_libraries.COUNTS, 0) > 0, "We borrowerd more than we lent", "") AS "Net borrower",  
  If(Coalesce(not_ours_at_ours.COUNTS, 0) -  Coalesce(ours_at_other_libraries.COUNTS, 0) < 0, "We lent more than we borrowed", "") AS "Net lender",
  Concat(Format(Coalesce(not_ours_at_ours.COUNTS, 0) / Coalesce(ours_at_other_libraries.COUNTS, 0), 2), " : 1") AS "Borrowed to lent ratio"
FROM
  branches LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS COUNTS
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN
      deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      statistics.branch NOT LIKE 
        If(
          Coalesce(items.homebranch, deleteditems.homebranch) LIKE "DONI%", 
          "DONI%", 
          If(
            Coalesce(items.homebranch, deleteditems.homebranch) LIKE "PH%", 
            "PH%", 
            Coalesce(items.homebranch, deleteditems.homebranch)
          )
        )
    GROUP BY
      statistics.branch) not_ours_at_ours ON not_ours_at_ours.branch =
      branches.branchcode LEFT JOIN
  (SELECT
      Coalesce(items.homebranch, deleteditems.homebranch) AS branch,
      Count(*) AS COUNTS
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN
      deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Coalesce(items.homebranch, deleteditems.homebranch) NOT LIKE  
        If(
          statistics.branch LIKE "DONI%", 
          "DONI%", 
          If(
            statistics.branch LIKE "PH%", 
            "PH%", 
            statistics.branch
          )
        )
    GROUP BY
      Coalesce(items.homebranch, deleteditems.homebranch))
  ours_at_other_libraries ON ours_at_other_libraries.branch =
      branches.branchcode

























