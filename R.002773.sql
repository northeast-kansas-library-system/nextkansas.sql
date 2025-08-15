/*
R.002773

----------

Name: GHW - Card prefix report part 2
Created by: George Williams

----------

Group: -
     -

Created on: 2016-09-14 09:19:42
Modified on: 2024-01-17 11:36:36
Date last run: 2025-06-11 13:47:35

----------

Public: 0
Expiry: 0

----------

 
Attempts to discern which libraries are using a specified card prefix
reports on current cards in NExpress
shows a count of how many cards with the specified prefix exist at all NExpress libraries
grouped and sorted by patron home library

Notes:
Report 2771 is the companion to this report
Report created at the request of Robin Hastings.
Report created by George Williams.


----------
*/



SELECT
  borrowers.branchcode AS BORROWERS_HOME_LIBRARY,
  Count(borrowers.cardnumber) AS CARD_COUNT
FROM
  borrowers
WHERE
  borrowers.cardnumber LIKE CONCAT((&lt;&gt;),'%')
GROUP BY
  borrowers.branchcode
  WITH ROLLUP

























