/*
R.003195

----------

Name: GHW - JSON report for in transit locations
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-04-15 14:47:23
Modified on: 2019-06-19 13:27:35
Date last run: 2022-03-23 09:00:27

----------

Public: 0
Expiry: 1

----------



----------
*/



SELECT
  CONCAT("<h1>KLE code:  ", branches.branchnotes, "</h1>") AS SHIP_TO
FROM
  branches
WHERE
  branches.branchname LIKE Concat("%", <<branchname>>, "%")

























