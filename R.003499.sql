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
Date last run: 2025-08-01 00:30:02

----------

Public: 0
Expiry: 300

----------

 
Circulation by library details spreadsheet report - hourly circulation 
Shows counts of check-outs, renewals, and returns in the previous calendar month 
At all Next Search Catalog libraries 
grouped and sorted by library name, date, and hour 
 
Notes: 
 
 
  CKO =  number of items newly checked out 
  RENEW = number of items renewed 
  RETURNS = number of items checked in 
  TOTAL_CKO_RENEW_RETURN = sum of the previous 3 columns 
  CKO_BORROWERS = number of unique accounts used to check out the items in the CKO column 
  RENEW_BORROWERS = number of unique accounts used to renew the items in the RENEW column 
  CKO_AND_RENEW_BORROWERS = number of unique accounts used to check out and renew items 
 
 
OPAC renewals are counted as occurring at the library where the item was originally checked out.  This is why you may see data for days and times that your library is closed. 
 
This report and these notes updated on 2025.02.08 
 
Click here to download as a csv file 
#monthly #statistics #library #details #hourly #cirulation_by_library_details 
 
 

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

























