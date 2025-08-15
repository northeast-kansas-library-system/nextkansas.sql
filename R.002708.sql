/*
R.002708

----------

Name: Intra-Consortial Loans at a branch during a selected date range
Created by: George Williams

----------

Group: Circulation
     Circ Stats

Created on: 2016-07-12 17:21:02
Modified on: 2023-10-16 22:05:48
Date last run: 2023-04-05 15:51:23

----------

Public: 0
Expiry: 0

----------

 
This report counts items that were checked out at a library that did not have a homebranch of that same library.
Counts items that were checked out during a specified date range (between 12:00 a.m. on the START DATE and 11:59 p.m. on the END DATE)
Counts all items checked out or renewed at a specified branch that were not owned by that branch
grouped by check-out-branch, shelving-location, and collection-code
sorted by check-out-branch, shelving-location, and collection-code
includes rollup totals for each grouping sub-set

Notes:
This report is similar to report 2707 which does the same thing but only shows items checked out or renewed in the previous calendar month.


----------
*/



SELECT 
 CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE, SUM(C_R) AS CHECKOUTS_PLUS_RENEWALS
FROM
 (
SELECT 
 statistics.branch AS CHECK_OUT_BRANCH, items.location AS SHELVING_LOCATION, statistics.ccode AS COLLECTION_CODE, COUNT(*) AS C_R
FROM
 statistics
JOIN items ON statistics.itemnumber = items.itemnumber
WHERE
 (statistics.datetime BETWEEN (@StartDate:= &lt;&gt;)  AND (@EndDate:= &lt;&gt;+ INTERVAL 1 DAY)) AND (statistics.type = 'issue' OR statistics.type = 'renew') AND (items.homebranch &lt;&gt; statistics.branch)
GROUP BY CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE 

UNION

SELECT 
 statistics.branch AS CHECK_OUT_BRANCH, deleteditems.location AS SHELVING_LOCATION, statistics.ccode AS COLLECTION_CODE, COUNT(*) AS C_R
FROM
 statistics
JOIN deleteditems ON statistics.itemnumber = deleteditems.itemnumber
WHERE
 (statistics.datetime BETWEEN @StartDate  AND @EndDate) AND (statistics.type = 'issue' OR statistics.type = 'renew') AND (deleteditems.homebranch &lt;&gt; statistics.branch)
GROUP BY CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE) AS X
WHERE CHECK_OUT_BRANCH = &lt;&gt;
GROUP BY CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE WITH ROLLUP

























