/*
R.003028

----------

Name: GHW - Circulation Stats - Circulation count by flexible dates
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     -

Created on: 2018-01-04 09:13:49
Modified on: 2018-04-16 11:13:37
Date last run: 2022-12-14 13:14:30

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Counts circulation (checkouts and renewals) based on flexible date settings</p>
<ul><li>Counts circulation based on the date parameters you set</li>
<li>at the library you choose</li>
<li>grouped and sorted by checkout branch and date of checkout</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Please note that items renewed via the OPAC are counted as renewals at the library where the item was checked out.  Therefore, if you see a circulation count at a library on a day that the library is normally closed, it is almost certainly due to a renewal initiated by the patron via the OPAC.</p>
<p></p>
<p>This report replaces reports 2396, 2397, 2398, 2399, 2400, 2401, and 2402</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3028&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  branches.branchcode,
  checkouts.DATE,
  checkouts.DAY_OF_WEEK,
  Coalesce(checkouts.count, 0) AS CKO_COUNT
FROM
  branches
  LEFT JOIN (SELECT
        statistics.branch,
        Date_Format(statistics.datetime, "%Y-%m-%d") AS DATE,
        Date_Format(statistics.datetime, "%Y") AS YEAR,
        Date_Format(statistics.datetime, "%m") AS MONTH,
        Date_Format(statistics.datetime, "%d") AS DATEX,
        Date_Format(statistics.datetime, "%W") AS DAY_OF_WEEK,
        Count(*) AS count
      FROM
        statistics
      WHERE
        (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
        Date_Format(statistics.datetime, "%Y") LIKE <<Choose checkout year|LYEAR>> AND
        Date_Format(statistics.datetime, "%m") LIKE <<Choose checkout month|LMONTH>> AND
        Date_Format(statistics.datetime, "%d") LIKE <<Choose checkout date|LDATE>> AND
        Date_Format(statistics.datetime, "%W") LIKE <<Choose checkout day|LDAYOFWEEK>>
      GROUP BY
        statistics.branch,
        Date_Format(statistics.datetime, "%Y-%m-%d")) checkouts ON branches.branchcode = checkouts.branch
WHERE
  branches.branchcode LIKE <<Choose checkout branch|LBRANCH>>
ORDER BY
  branches.branchcode,
  checkouts.DATE

























