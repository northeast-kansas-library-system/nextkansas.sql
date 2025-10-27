/*
R.003422

----------

Name: 0025 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 21:38:26
Modified on: 2025-04-30 10:11:24
Date last run: 2025-10-09 10:52:09

----------

Public: 0
Expiry: 300

----------

 
Monthly overview - total number of bibliographic records system-wide 
Shows holdings count for the previous calendar month 
For the entire Next Search Catalog consortium 
 
Notes: 
 
Generates data for: 
 
  Total items owned on the last day of the month last month 
 
 
This report and these notes updated on 2022.03.10 
 
Click here to download as a csv file 
#monthly #statistics #overview #monthly_overview 
 
 

----------
*/



SELECT 
  'DESCRIPTION' AS DESCRIPTION,
  'COUNT' AS COUNT
UNION  
SELECT 
  'Total biblios on last day of last month' AS DESCRIPTION,
  count(*) AS COUNT
FROM 
  biblio
WHERE 
  biblio.datecreated &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)

























