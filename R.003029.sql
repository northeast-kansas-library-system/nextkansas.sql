/*
R.003029

----------

Name: GHW - Circulation Stats - Checkin count by flexible dates
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     -

Created on: 2018-01-04 09:58:40
Modified on: 2018-04-16 11:13:41
Date last run: 2023-03-08 11:45:41

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Counts checkins based on flexible date settings</p>
<ul><li>Counts checkins based on the date parameters you set</li>
<li>at the library you choose</li>
<li>grouped and sorted by checkin branch and date of checkin</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report replaces reports 2404, 2405, 2406, 2407, 2408, 2409, 2410</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3029&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  branches.branchcode,
  checkins.DATE,
  checkins.DAY_OF_WEEK,
  Coalesce(checkins.count, 0) AS CKI_COUNT
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
        statistics.type = 'return' AND
        Date_Format(statistics.datetime, "%Y") LIKE <<Choose checkin year|LYEAR>> AND
        Date_Format(statistics.datetime, "%m") LIKE <<Choose checkin month|LMONTH>> AND
        Date_Format(statistics.datetime, "%d") LIKE <<Choose checkin date|LDATE>> AND
        Date_Format(statistics.datetime, "%W") LIKE <<Choose checkin day|LDAYOFWEEK>>
      GROUP BY
        statistics.branch,
        Date_Format(statistics.datetime, "%Y-%m-%d")) checkins ON branches.branchcode = checkins.branch
WHERE
  branches.branchcode LIKE <<Choose checkin library|LBRANCH>>
GROUP BY
  branches.branchcode,
  checkins.DATE
ORDER BY
  branches.branchcode,
  checkins.DATE

























