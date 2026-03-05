/*
R.003195

----------

Name: GHW - JSON report for in transit locations
Created by: George Williams

----------

Group: -
     -

Created on: 2019-04-15 14:47:23
Modified on: 2019-06-19 13:27:35
Date last run: 2024-10-10 15:20:26

----------

Public: 0
Expiry: 1

----------



----------
*/



SELECT
  CONCAT("KLE code:  ", branches.branchnotes, "") AS SHIP_TO
FROM
  branches
WHERE
  branches.branchname LIKE Concat("%", &lt;&gt;, "%")

























