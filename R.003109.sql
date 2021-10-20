/*
R.003109

----------

Name: GHW - Monthly E
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2018-08-02 16:15:17
Modified on: 2018-09-25 10:54:25
Date last run: 2020-08-03 13:58:06

----------

Public: 0
Expiry: 300

----------

<div id="reportinfo">
<p>Generates monthly statistics for Next intra-consortial ILLs - i.e. items from other Next libraries you received to fill requests</p>
<ul><li>Shows Next ILL borrow counts for the previous calendar month</li>
<li>At all Next Kansas libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Corresponds with column T on the monthly circulation spreadsheet for 2018.</p>
<p>This report is designed to run on Koha 17.11 and greater.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3109&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3109">Click here to download as a csv file</a></p>
</div>

----------
*/



SELECT
  Concat(Year(Now() - INTERVAL 1 MONTH), ".", LPad(Month(Now() - INTERVAL 1 MONTH), 2, 0)) AS YYYY_MM,
  branches.branchcode,
  Coalesce(ILL_BORROWED.count, 0) AS NX_ILL_BORROWED_LM
FROM
  branches
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
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode

























