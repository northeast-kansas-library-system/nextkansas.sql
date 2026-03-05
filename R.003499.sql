/*
R.003499

----------

Name: 0030 - 2024_99_b_circulation_hourly monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-04-30 15:05:03
Modified on: 2025-04-30 10:22:12
Date last run: 2026-01-01 00:30:02

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Circulation by library details spreadsheet report - hourly circulation&lt;/p&gt; 
&lt;ul&gt;&lt;li&gt;Shows counts of check-outs, renewals, and returns in the previous calendar month&lt;/li&gt; 
&lt;li&gt;At all Next Search Catalog libraries&lt;/li&gt; 
&lt;li&gt;grouped and sorted by library name, date, and hour&lt;/li&gt; 
&lt;/ul&gt;&lt;br /&gt; 
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;ul&gt; 
  &lt;li&gt;CKO =  number of items newly checked out&lt;/li&gt; 
  &lt;li&gt;RENEW = number of items renewed&lt;/li&gt; 
  &lt;li&gt;RETURNS = number of items checked in&lt;/li&gt; 
  &lt;li&gt;TOTAL_CKO_RENEW_RETURN = sum of the previous 3 columns&lt;/li&gt; 
  &lt;li&gt;CKO_BORROWERS = number of unique accounts used to check out the items in the CKO column&lt;/li&gt; 
  &lt;li&gt;RENEW_BORROWERS = number of unique accounts used to renew the items in the RENEW column&lt;/li&gt; 
  &lt;li&gt;CKO_AND_RENEW_BORROWERS = number of unique accounts used to check out and renew items&lt;/li&gt; 
&lt;/ul&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p&gt;OPAC renewals are counted as occurring at the library where the item was originally checked out.  This is why you may see data for days and times that your library is closed.&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p class="updated"&gt;This report and these notes updated on 2025.02.08&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3499"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt; 
&lt;p class= "notetags" style="display: none;"&gt;#monthly #statistics #library #details #hourly #cirulation_by_library_details&lt;/p&gt; 
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
&lt;/div&gt; 

----------
*/



SELECT 'Library name' AS 'Library name',  
  'Date' AS 'Date',  
  'Day' AS 'Day',  
  'Hour' AS 'Hour',  
  'Checkouts' AS 'Checkouts',  
  'Renewals' AS 'Renewals',  
  'Returns' AS 'Returns',  
  'Checkouts + renewals + returns' AS 'Checkouts + renewals + returns',  
  'Check out borrower count' AS 'Check out borrower count',  
  'Renewal borrower count' AS 'Renewal borrower count',  
  'Check out + renewal borrower count' AS 'Check out + renewal borrower count'
UNION 
(SELECT 
  branchess.branchname AS "Library name", 
  ALL_STATS.DATE AS "Date", 
  ALL_STATS.DAY AS "Day", 
  Concat(ALL_STATS.HOUR_OF_DAY, ":00 - ", ALL_STATS.HOUR_OF_DAY, ":59") AS "Hour", 
  Coalesce(CKO.COUNT, 0) AS "Checkouts", 
  Coalesce(RENEWALS.COUNT, 0) AS "Renewals", 
  Coalesce(RETURNS.COUNT, 0) AS "Returns", 
  ALL_STATS.COUNT AS "Checkouts + renewals + returns", 
  Coalesce(ckoborrowers.Count_borrowernumber, 0) AS "Check out borrower count", 
  Coalesce(renewborrowers.Count_borrowernumber, 0) AS "Renewal borrower count", 
  totalborrowers.Count_borrowernumber AS "Check out + renewal borrower count" 
FROM 
  ( 
    SELECT 
     branches.branchcode, 
     branches.branchname 
   FROM 
     branches) branchess 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     count(&ast;) AS COUNT 
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
     Hour(statistics.datetime) 
  ) ALL_STATS 
    ON ALL_STATS.branch = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     count(&ast;) AS COUNT 
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
     Hour(statistics.datetime) 
  ) RETURNS 
    ON RETURNS.branch = branchess.branchcode 
    AND RETURNS.DATE = ALL_STATS.DATE 
    AND RETURNS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     count(&ast;) AS COUNT 
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
     Hour(statistics.datetime) 
  ) CKO 
    ON CKO.branch = branchess.branchcode 
    AND CKO.DATE = ALL_STATS.DATE 
    AND CKO.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     count(&ast;) AS COUNT 
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
     Hour(statistics.datetime) 
  ) RENEWALS 
    ON RENEWALS.branch = branchess.branchcode 
    AND RENEWALS.DATE = ALL_STATS.DATE 
    AND RENEWALS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN 
  ( 
    SELECT 
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
     Hour(statistics.datetime) 
  ) totalborrowers 
    ON totalborrowers.branch = branchess.branchcode 
    AND totalborrowers.DATE = ALL_STATS.DATE 
    AND totalborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN 
  ( 
    SELECT 
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
     Hour(statistics.datetime) 
  ) ckoborrowers 
    ON ckoborrowers.branch = branchess.branchcode 
    AND ckoborrowers.DATE = ALL_STATS.DATE 
    AND ckoborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN 
  ( 
    SELECT 
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
     Hour(statistics.datetime) 
  ) renewborrowers 
    ON renewborrowers.branch = branchess.branchcode 
    AND renewborrowers.DATE = ALL_STATS.DATE 
    AND renewborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
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
  ALL_STATS.HOUR_OF_DAY )

























