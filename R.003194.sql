/*
R.003194

----------

Name: GHW - JSON report for in transit locations
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-04-12 15:39:09
Modified on: 2019-04-12 16:35:48
Date last run: 2021-05-17 16:53:12

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
  branches.branchcode LIKE Concat(<<branchcode>>, "%")



