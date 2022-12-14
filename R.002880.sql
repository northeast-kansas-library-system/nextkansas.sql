/*
R.002880

----------

Name: GHW - Monthly 101 - Circulation
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2017-01-09 09:39:56
Modified on: 2022-12-02 11:10:25
Date last run: 2022-12-02 10:50:36

----------

Public: 0
Expiry: 0

----------

<p><ins>Notes:</ins></p>
<p></p>
<p class="updated">SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."</p>
<p></p>

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
  branches LEFT JOIN
  (SELECT
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
      statistics.branch) CIR_RENEW_LM ON branches.branchcode =
      CIR_RENEW_LM.branch LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (If(
          statistics.location LIKE "CART", 
          items.permanent_location,
          statistics.location
        ) LIKE '%AD%' OR
        statistics.location IS NULL)
    GROUP BY
      statistics.branch) ADULT ON branches.branchcode = ADULT.branch LEFT JOIN
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
      ILL_BORROWED.tobranch LEFT JOIN
  (SELECT
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
  LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      statistics.location <> "" AND
      If(
        statistics.location LIKE "CART", 
        items.permanent_location,
        statistics.location
      ) NOT LIKE "%AD%"
    GROUP BY
      statistics.branch) YOUTH ON branches.branchcode = YOUTH.branch
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode

























