/*
R.003671

----------

Name: GHW - In transit - Count of items still in transit by week
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-10-17 15:13:34
Modified on: 2022-12-14 16:46:50
Date last run: 2022-12-14 16:44:12

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
  <p>Counts the items that are still in transit and orders them by the week they were shipped</p>
  <ul>
    <li>Shows data for items that are currently in transit</li>
    <li>at all Next libraries</li>
    <li>grouped and sorted by the week shipped</li>
    <li>links to report 3672</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Created to isolate possible courier issues.</p>
  <p></p>
  <p class= "notetags" style="display: none;">#transit #courier</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



SELECT 
  weeks.START_END AS WEEK_SHIPPED, 
  all_shipped.COUNT AS SHIPPED_TOTAL, 
  shipped_and_received.COUNT AS SHIPPED_AND_RECEIVED, 
  shipped_then_cancelled.COUNT AS SHIPPED_CNX, 
  Coalesce(shipped_but_not_yet_received.COUNT, 0) AS STILL_IN_TRANSIT, 
  Concat( 
    '<a class="btn btn-default btn-xs noprint"', 
    'href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=3672', 
    '&phase=Run+this+report', 
    '&param_name=Between+%28YYYY-MM-DD%29', 
    '&sql_params=', 
    weeks.d1, 
    '&param_name=and+%28YYYY-MM-DD%29', 
    '&sql_params=', 
    weeks.d2, 
    '" target="_blank">All items for week</a>' 
  ) AS REPORT_3672 
FROM 
  ( 
    SELECT 
      Concat_Ws('', 
        Str_To_Date(Concat(YearWeek(branchtransfers.datesent, 0), ' Sunday'), '%X%V %W'), 
        ' - ', 
        (Str_To_Date(Concat(YearWeek(branchtransfers.datesent + Interval 7 DAY, 0), ' Sunday'), '%X%V %W') - Interval 1 DAY) 
      ) AS START_END, 
      YearWeek(branchtransfers.datesent, 0) AS YEARWEEK, 
      Concat_Ws('', 
        Str_To_Date(Concat(YearWeek(branchtransfers.datesent, 0), ' Sunday'), '%X%V %W') 
      ) AS d1, 
      Concat_Ws('', 
        Str_To_Date(Concat(YearWeek(branchtransfers.datesent + Interval 7 DAY, 0), ' Sunday'), '%X%V %W') - Interval 1 DAY 
      ) AS d2 
    FROM branchtransfers 
    WHERE branchtransfers.datesent < Date_Sub(Date(Now()), Interval DayOfWeek(Now()) + 6 DAY) 
    GROUP BY YearWeek(branchtransfers.datesent, 0) 
  ) weeks 
LEFT JOIN 
  ( 
    SELECT 
      YearWeek(branchtransfers.datesent, 0) AS SHIPPED_WEEK, 
      Count(DISTINCT branchtransfers.branchtransfer_id) AS COUNT 
    FROM branchtransfers 
    GROUP BY YearWeek(branchtransfers.datesent, 0) 
  ) all_shipped ON all_shipped.SHIPPED_WEEK = weeks.YEARWEEK 
LEFT JOIN 
  ( 
    SELECT 
      YearWeek(branchtransfers.datesent, 0) AS SHIPPED_WEEK, 
      Count(DISTINCT branchtransfers.branchtransfer_id) AS COUNT 
    FROM branchtransfers 
    WHERE branchtransfers.datecancelled IS NOT NULL 
    GROUP BY YearWeek(branchtransfers.datesent, 0) 
  ) shipped_then_cancelled ON shipped_then_cancelled.SHIPPED_WEEK = weeks.YEARWEEK 
LEFT JOIN 
  ( 
    SELECT 
      YearWeek(branchtransfers.datesent, 0) AS SHIPPED_WEEK, 
      Count(DISTINCT branchtransfers.branchtransfer_id) AS COUNT 
    FROM branchtransfers 
    WHERE branchtransfers.datearrived IS NOT NULL 
    GROUP BY YearWeek(branchtransfers.datesent, 0) 
  ) shipped_and_received ON shipped_and_received.SHIPPED_WEEK = weeks.YEARWEEK 
LEFT JOIN 
  ( 
    SELECT 
      YearWeek(branchtransfers.datesent, 0) AS SHIPPED_WEEK, 
      Count(DISTINCT branchtransfers.branchtransfer_id) AS COUNT 
    FROM branchtransfers 
    WHERE 
      branchtransfers.datecancelled IS NULL AND 
      branchtransfers.datearrived IS NULL 
    GROUP BY YearWeek(branchtransfers.datesent, 0) 
  ) shipped_but_not_yet_received ON shipped_but_not_yet_received.SHIPPED_WEEK = weeks.YEARWEEK 
WHERE 
  Coalesce(shipped_but_not_yet_received.COUNT, 0) > 0 
GROUP BY 
  weeks.START_END, 
  all_shipped.COUNT, 
  shipped_and_received.COUNT, 
  shipped_then_cancelled.COUNT, 
  Coalesce(shipped_but_not_yet_received.COUNT, 0), 
  weeks.YEARWEEK 
ORDER BY 
  weeks.YEARWEEK DESC

























