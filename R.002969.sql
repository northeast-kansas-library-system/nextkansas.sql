/*
R.002969

----------

Name: GHW - Monthly 104
Created by: George Williams

----------

Group: Statistics
     End of month statistics

Created on: 2017-07-01 13:22:33
Modified on: 2024-01-17 11:51:46
Date last run: 2025-06-12 12:28:07

----------

Public: 0
Expiry: 300

----------

 
Generates end of month data for spreadsheet report
Reports end of month data for Next-wide spreadsheet - Cells G58, H58, and I58


Click here to download as a csv file
Monthly




----------
*/



SELECT
  'Total biblios on last day of last month' AS DESCRIPTION,
  count(*) AS COUNT
FROM
  biblio
WHERE
  biblio.datecreated &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
UNION
SELECT
  'Biblios added last month' AS DESCRIPTION,
  Count(*)
FROM
  biblio
WHERE
  Month(biblio.datecreated) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(biblio.datecreated) = Year(Now() - INTERVAL 1 MONTH)
UNION
SELECT
  'Biblios deleted last month' AS DESCRIPTION,
  Count(*)
FROM
  deletedbiblio
WHERE
  Month(deletedbiblio.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(deletedbiblio.timestamp) = Year(Now() - INTERVAL 1 MONTH)

























