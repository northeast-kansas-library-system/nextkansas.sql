/*
R.002707

----------

Name: Intra-Consortial Loans at a branch in the previous calendar month
Created by: George H Williams

----------

Group: Circulation
     Circ Stats

Created on: 2016-07-12 16:32:22
Modified on: 2016-07-12 18:21:58
Date last run: 2023-05-10 13:20:50

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>This report counts items that were checked out at a library that did not have a homebranch of that same library.</p>
<ul><li>Counts items that were checked out during the previous calendar month (between 12:00 a.m. on the first of the month and 11:59 p.m. on the final day of the month)</li>
<li>Counts all items checked out or renewed at a specified branch that were not owned by that branch</li>
<li>grouped by check-out-branch, shelving-location, and collection-code</li>
<li>sorted by check-out-branch, shelving-location, and collection-code</li>
<li>includes rollup totals for each grouping sub-set</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>This report is similar to report 2708 which does the same thing but allows you to select a date range</p>
</div>

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
 statistics.datetime BETWEEN (CONCAT(DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 1 MONTH), '%Y-%m-'), '01')) AND (CONCAT(DATE_FORMAT(LAST_DAY(NOW()), '%Y-%m-'), '01')) AND (statistics.type = 'issue' OR statistics.type = 'renew') AND (items.homebranch <> statistics.branch)
GROUP BY CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE 

UNION

SELECT 
 statistics.branch AS CHECK_OUT_BRANCH, deleteditems.location AS SHELVING_LOCATION, statistics.ccode AS COLLECTION_CODE, COUNT(*) AS C_R
FROM
 statistics
JOIN deleteditems ON statistics.itemnumber = deleteditems.itemnumber
WHERE
 statistics.datetime BETWEEN (CONCAT(DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 1 MONTH), '%Y-%m-'), '01')) AND (CONCAT(DATE_FORMAT(LAST_DAY(NOW()), '%Y-%m-'), '01')) AND (statistics.type = 'issue' OR statistics.type = 'renew') AND (deleteditems.homebranch <> statistics.branch)
GROUP BY CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE) AS X
WHERE CHECK_OUT_BRANCH = <<Select branch|branches>>
GROUP BY CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE WITH ROLLUP

























