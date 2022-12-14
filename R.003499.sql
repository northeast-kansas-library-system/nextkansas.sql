/*
R.003499

----------

Name: GHW - B1 Circulation by library details - hourly statistics - Next Search Catalog
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2021-04-30 15:05:03
Modified on: 2022-04-05 15:29:38
Date last run: 2022-12-01 00:30:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Circulation by library details spreadsheet report - hourly circulation</p> 
<ul><li>Shows counts of check-outs, renewals, and returns in the previous calendar month</li> 
<li>At all Next Search Catalog libraries</li> 
<li>grouped and sorted by library name, date, and hour</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<ul> 
  <li>CKO =  number of items newly checked out</li> 
  <li>RENEW = number of items renewed</li> 
  <li>RETURNS = number of items checked in</li> 
  <li>TOTAL_CKO_RENEW_RETURN = sum of the previous 3 columns</li> 
  <li>CKO_BORROWERS = number of unique accounts used to check out the items in the CKO column</li> 
  <li>RENEW_BORROWERS = number of unique accounts used to renew the items in the RENEW column</li> 
  <li>CKO_AND_RENEW_BORROWERS = number of unique accounts used to check out and renew items</li> 
</ul> 
<p></p> 
<p>OPAC renewals are counted as occurring at the library where the item was originally checked out.  This is why you may see data for days and times that your library is closed.</p> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3499">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #library #details #hourly</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.DAY,
  Concat(ALL_STATS.HOUR_OF_DAY, ":00 - ", ALL_STATS.HOUR_OF_DAY, ":59") AS HOUR,
  Coalesce(CKO.COUNT, 0) AS CKO,
  Coalesce(RENEWALS.COUNT, 0) AS RENEW,
  Coalesce(RETURNS.COUNT, 0) AS RETURNS,
  ALL_STATS.COUNT AS TOTAL_CKO_RENEW_RETURN,
  Coalesce(ckoborrowers.Count_borrowernumber, 0) AS CKO_BORROWERS,
  Coalesce(renewborrowers.Count_borrowernumber, 0) AS RENEW_BORROWERS,
  totalborrowers.Count_borrowernumber AS CKO_AND_RENEW_BORROWERS
FROM
  (SELECT
     branches.branchcode,
     branches.branchname
   FROM
     branches) branchess LEFT JOIN
  (SELECT
     statistics.branch,
     DayName(statistics.datetime) AS DAY,
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
     Hour(statistics.datetime) AS HOUR_OF_DAY,
     count(*) AS COUNT
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew' OR
         statistics.type = 'return') AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch,
     DayName(statistics.datetime),
     Date_Format(statistics.datetime, '%Y-%m-%d'),
     Hour(statistics.datetime)) ALL_STATS ON ALL_STATS.branch =
      branchess.branchcode LEFT JOIN
  (SELECT
     statistics.branch,
     DayName(statistics.datetime) AS DAY,
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
     Hour(statistics.datetime) AS HOUR_OF_DAY,
     count(*) AS COUNT
   FROM
     statistics
   WHERE
     statistics.type = 'return' AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch,
     DayName(statistics.datetime),
     Date_Format(statistics.datetime, '%Y-%m-%d'),
     Hour(statistics.datetime)) RETURNS ON RETURNS.branch = branchess.branchcode
      AND
      RETURNS.DATE = ALL_STATS.DATE AND
      RETURNS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
     statistics.branch,
     DayName(statistics.datetime) AS DAY,
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
     Hour(statistics.datetime) AS HOUR_OF_DAY,
     count(*) AS COUNT
   FROM
     statistics
   WHERE
     statistics.type = 'issue' AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch,
     DayName(statistics.datetime),
     Date_Format(statistics.datetime, '%Y-%m-%d'),
     Hour(statistics.datetime)) CKO ON CKO.branch = branchess.branchcode AND
      CKO.DATE = ALL_STATS.DATE AND
      CKO.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
     statistics.branch,
     DayName(statistics.datetime) AS DAY,
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
     Hour(statistics.datetime) AS HOUR_OF_DAY,
     count(*) AS COUNT
   FROM
     statistics
   WHERE
     statistics.type = 'renew' AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch,
     DayName(statistics.datetime),
     Date_Format(statistics.datetime, '%Y-%m-%d'),
     Hour(statistics.datetime)) RENEWALS ON
      RENEWALS.branch = branchess.branchcode AND
      RENEWALS.DATE = ALL_STATS.DATE AND
      RENEWALS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
     statistics.branch,
     DayName(statistics.datetime) AS DAY,
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
     Hour(statistics.datetime) AS HOUR_OF_DAY,
     Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
   FROM
     statistics
   WHERE
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     (statistics.type = 'issue' OR
         statistics.type = 'renew')
   GROUP BY
     statistics.branch,
     DayName(statistics.datetime),
     Date_Format(statistics.datetime, '%Y-%m-%d'),
     Hour(statistics.datetime)) totalborrowers ON totalborrowers.branch =
      branchess.branchcode AND
      totalborrowers.DATE = ALL_STATS.DATE AND
      totalborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
     statistics.branch,
     DayName(statistics.datetime) AS DAY,
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
     Hour(statistics.datetime) AS HOUR_OF_DAY,
     Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
   FROM
     statistics
   WHERE
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     statistics.type = 'issue'
   GROUP BY
     statistics.branch,
     DayName(statistics.datetime),
     Date_Format(statistics.datetime, '%Y-%m-%d'),
     Hour(statistics.datetime)) ckoborrowers ON ckoborrowers.branch =
      branchess.branchcode AND
      ckoborrowers.DATE = ALL_STATS.DATE AND
      ckoborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
     statistics.branch,
     DayName(statistics.datetime) AS DAY,
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
     Hour(statistics.datetime) AS HOUR_OF_DAY,
     Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
   FROM
     statistics
   WHERE
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     statistics.type = 'renew'
   GROUP BY
     statistics.branch,
     DayName(statistics.datetime),
     Date_Format(statistics.datetime, '%Y-%m-%d'),
     Hour(statistics.datetime)) renewborrowers ON renewborrowers.branch =
      branchess.branchcode AND
      renewborrowers.DATE = ALL_STATS.DATE AND
      renewborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY
WHERE
  branchess.branchcode LIKE '%'
GROUP BY
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.DAY,
  ALL_STATS.HOUR_OF_DAY
ORDER BY
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.DAY,
  ALL_STATS.HOUR_OF_DAY

























