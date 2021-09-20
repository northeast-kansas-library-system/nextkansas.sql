/*
R.002880

----------

Name: GHW - Monthly 101 - Circulation
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2017-01-09 09:39:56
Modified on: 2019-07-01 16:06:31
Date last run: 2021-09-03 09:03:24

----------

Public: 0
Expiry: 0

----------

<p style="display: none;">MNTHLY</p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=2880">Click here to download as a csv file</a></p>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(CIR_RENEW_LM.count, 0) AS CHECKOUT_RENEW_LM,
  Coalesce(ADULT.count, 0) AS CR_ADULT_LM,
  Coalesce(YOUTH.count, 0) AS CR_YOUTH_LM,
  Coalesce(ILL_LOANED.count, 0) AS NX_ILL_LOANED_LM,
  Coalesce(ILL_BORROWED.count, 0) AS NX_ILL_BORROWED_LM,
  Coalesce(ACCT_USED.count, 0) AS PATRON_LM
FROM
  branches
  LEFT JOIN (SELECT
        statistics.branch,
        Count(*) AS count
      FROM
        statistics
      WHERE
        (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        statistics.branch) CIR_RENEW_LM ON branches.branchcode = CIR_RENEW_LM.branch
  LEFT JOIN (SELECT
        statistics.branch,
        Count(*) AS count
      FROM
        statistics
      WHERE
        (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
        (statistics.location = 'ADULT' OR
          statistics.location = 'LVPLADULT' OR
          statistics.location IS NULL)
      GROUP BY
        statistics.branch) ADULT ON branches.branchcode = ADULT.branch
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
  LEFT JOIN (SELECT
        branchtransfers.tobranch,
        COUNT(*) AS count
      FROM
        branchtransfers
        LEFT JOIN items ON branchtransfers.itemnumber = items.itemnumber
      WHERE
        branchtransfers.tobranch <> items.homebranch AND
        Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND
        branchtransfers.frombranch <> branchtransfers.tobranch AND
        branchtransfers.comments IS NULL
      GROUP BY
        branchtransfers.tobranch) ILL_BORROWED ON branches.branchcode = ILL_BORROWED.tobranch
  LEFT JOIN (SELECT
        statistics.branch,
        Count(DISTINCT statistics.borrowernumber) AS count
      FROM
        statistics
      WHERE
        (statistics.type = 'issue' OR
          statistics.type = 'renew' OR
          statistics.type = 'localuse') AND
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        statistics.branch) ACCT_USED ON branches.branchcode = ACCT_USED.branch
  LEFT JOIN (SELECT
        statistics.branch,
        Count(*) AS count
      FROM
        statistics
      WHERE
        (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
        statistics.location <> "" AND
        statistics.location <> "ADULT" AND
        statistics.location <> "LVPLADULT"
      GROUP BY
        statistics.branch) YOUTH ON branches.branchcode = YOUTH.branch
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



