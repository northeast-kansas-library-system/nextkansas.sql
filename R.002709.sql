/*
R.002709

----------

Name: LANSING - Adult Non-Fiction items checked out at LANSING but not owned by LANSING
Created by: George H Williams

----------

Group:  LANSING
     -

Created on: 2016-07-12 17:43:09
Modified on: 2021-10-20 10:20:40
Date last run: 2021-12-06 17:21:07

----------

Public: 0
Expiry: 0

----------

All non LANSING Adult Nonfiction checked out at LANSING in a specified date range.

----------
*/



SELECT 
 CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE, ITEM_CALL_NUMBER, SUM(C_R) AS CHECKOUTS_PLUS_RENEWALS
FROM
 (
SELECT 
 statistics.branch AS CHECK_OUT_BRANCH, items.location AS SHELVING_LOCATION, statistics.ccode AS COLLECTION_CODE, items.itemcallnumber AS ITEM_CALL_NUMBER, COUNT(*) AS C_R
FROM
 statistics
JOIN items ON statistics.itemnumber = items.itemnumber
WHERE
 (statistics.datetime BETWEEN (@StartDate:= <<between the beginning of the day on "START DATE"|date>>)  AND (@EndDate:= <<and the end of the day on "END DATE"|date>>+ INTERVAL 1 DAY)) AND (statistics.type = 'issue' OR statistics.type = 'renew') AND (items.homebranch <> statistics.branch)
GROUP BY CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE, ITEM_CALL_NUMBER

UNION

SELECT 
 statistics.branch AS CHECK_OUT_BRANCH, deleteditems.location AS SHELVING_LOCATION, statistics.ccode AS COLLECTION_CODE, deleteditems.itemcallnumber AS ITEM_CALL_NUMBER, COUNT(*) AS C_R
FROM
 statistics
JOIN deleteditems ON statistics.itemnumber = deleteditems.itemnumber
WHERE
 (statistics.datetime BETWEEN @StartDate  AND @EndDate) AND (statistics.type = 'issue' OR statistics.type = 'renew') AND (deleteditems.homebranch <> statistics.branch)
GROUP BY CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE, ITEM_CALL_NUMBER) AS X
WHERE CHECK_OUT_BRANCH = 'LANSING' AND SHELVING_LOCATION=<<Shelving Location|LOC>> AND COLLECTION_CODE = <<Collection code |CCODE>>
GROUP BY CHECK_OUT_BRANCH, SHELVING_LOCATION, COLLECTION_CODE, ITEM_CALL_NUMBER

























