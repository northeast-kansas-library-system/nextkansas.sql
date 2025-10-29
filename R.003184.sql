/*
R.003184

----------

Name: 0120 - 2024_99_g_net_borrower_lender monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2019-03-12 00:46:57
Modified on: 2025-04-30 11:55:24
Date last run: 2025-10-02 01:20:01

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
  'Library' AS 'Library',
  'Other Next library materials checked out at our library' AS 'Other Next library materials checked out at our library',
  'Our materials checked out at other Next libraries' AS 'Our materials checked out at other Next libraries',
  'NET' AS 'NET',
  'Net borrower' AS 'Net borrower',
  'Net lender' AS 'Net lender',
  'Borrowed to lent ratio' AS 'Borrowed to lent ratio'
UNION 
(SELECT 
  branches.branchname AS "Library",
  Coalesce(not_ours_at_ours.COUNTS, 0) AS "Other Next library materials checked out at our library",
  Coalesce(ours_at_other_libraries.COUNTS, 0) AS "Our materials checked out at other Next libraries",
  Coalesce(not_ours_at_ours.COUNTS, 0) - Coalesce(ours_at_other_libraries.COUNTS, 0) AS NET,
  If(
    Coalesce(not_ours_at_ours.COUNTS, 0) - Coalesce(ours_at_other_libraries.COUNTS, 0) &gt; 0,
    "We borrowerd more than we lent",
    ""
  ) AS "Net borrower",
  If(
    Coalesce(not_ours_at_ours.COUNTS, 0) - Coalesce(ours_at_other_libraries.COUNTS, 0) &lt; 0,
    "We lent more than we borrowed",
    ""
  ) AS "Net lender",
  Concat(
    Format(
      Coalesce(not_ours_at_ours.COUNTS, 0) / Coalesce(ours_at_other_libraries.COUNTS, 0),
      2
    ),
    " : 1"
  ) AS "Borrowed to lent ratio"
FROM branches
  LEFT JOIN 
    (
      SELECT statistics.branch,
        Count(*) AS COUNTS
      FROM statistics
        LEFT JOIN items ON items.itemnumber = statistics.itemnumber
        LEFT JOIN deleteditems ON deleteditems.itemnumber = statistics.itemnumber
      WHERE (
          statistics.type = 'issue'
          OR statistics.type = 'renew'
        )
        AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH)
        AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
        AND statistics.branch NOT LIKE If(
          Coalesce(items.homebranch, deleteditems.homebranch) LIKE "DONI%",
          "DONI%",
          If(
            Coalesce(items.homebranch, deleteditems.homebranch) LIKE "PH%",
            "PH%",
            Coalesce(items.homebranch, deleteditems.homebranch)
          )
        )
      GROUP BY statistics.branch
    ) not_ours_at_ours 
    ON not_ours_at_ours.branch = branches.branchcode
  LEFT JOIN 
    (
      SELECT Coalesce(items.homebranch, deleteditems.homebranch) AS branch,
        Count(*) AS COUNTS
      FROM statistics
        LEFT JOIN items ON items.itemnumber = statistics.itemnumber
        LEFT JOIN deleteditems ON deleteditems.itemnumber = statistics.itemnumber
      WHERE (
          statistics.type = 'issue'
          OR statistics.type = 'renew'
        )
        AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH)
        AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
        AND Coalesce(items.homebranch, deleteditems.homebranch) NOT LIKE If(
          statistics.branch LIKE "DONI%",
          "DONI%",
          If(
            statistics.branch LIKE "PH%",
            "PH%",
            statistics.branch
          )
        )
      GROUP BY 
      Coalesce(items.homebranch, deleteditems.homebranch)
    ) ours_at_other_libraries 
    ON ours_at_other_libraries.branch = branches.branchcode
ORDER BY
  branches.branchname
LIMIT 500
)

























