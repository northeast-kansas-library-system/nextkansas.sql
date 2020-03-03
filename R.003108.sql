/*
R.003108

----------

Name: GHW - Monthly D
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2018-08-02 16:11:28
Modified on: 2018-09-25 10:54:18
Date last run: 2019-11-03 17:45:41

----------

Public: 0
Expiry: 300

----------

<div id="reportinfo">
<p>Generates monthly statistics for Next intra-consortial ILLs - i.e. items you shipped to fill requests at other Next libraries</p>
<ul><li>Shows Next ILL loan counts for the previous calendar month</li>
<li>At all Next Kansas libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Corresponds with column S on the monthly circulation spreadsheet for 2018.</p>
<p>This report is designed to run on Koha 17.11 and greater.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3108&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3108">Click here to download as a csv file</a></p>
</div>

----------
*/

SELECT
  Concat(Year(Now() - INTERVAL 1 MONTH), ".", LPad(Month(Now() - INTERVAL 1 MONTH), 2, 0)) AS YYYY_MM,
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
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



