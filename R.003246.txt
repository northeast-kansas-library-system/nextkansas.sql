/*
R.003246

----------

Name: GHW ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-08 14:50:46
Modified on: 2019-08-08 14:50:46
Date last run: 2019-08-13 14:31:37

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branchesitypes.branchname,
  branchesitypes.description,
  Sum(itemsdeleteditems.replacementprice) AS Sum_replacementprice
FROM
  (
    SELECT
      branches.branchcode,
      branches.branchname,
      itemtypes.itemtype,
      itemtypes.description
    FROM
      branches,
      itemtypes
  ) branchesitypes
  LEFT JOIN statistics
    ON statistics.branch = branchesitypes.branchcode AND
      statistics.itemtype = branchesitypes.itemtype
  INNER JOIN (
    SELECT
      items.itemnumber,
      items.replacementprice
    FROM
      items
    UNION
    SELECT
      deleteditems.itemnumber,
      deleteditems.replacementprice
    FROM
      deleteditems
  ) itemsdeleteditems
    ON itemsdeleteditems.itemnumber = statistics.itemnumber
WHERE
  branchesitypes.branchcode LIKE "TONGANOXIE" AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
  (statistics.type = 'issue' OR
    statistics.type = 'renew')
GROUP BY
  branchesitypes.branchname,
  branchesitypes.description



