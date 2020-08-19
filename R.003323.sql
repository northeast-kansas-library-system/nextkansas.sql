/*
R.003323

----------

Name: GHW - Item type count
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-04-30 18:24:01
Modified on: 2020-05-01 13:34:54
Date last run: 2020-08-03 17:10:00

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branchitypes.branchname,
  branchitypes.description,
  Coalesce(icounts.Count_itemnumber, 0) AS NUMBER_OF_ITEMS
FROM
  (SELECT
      branches.branchcode,
      branches.branchname,
      itemtypes.itemtype,
      itemtypes.description
    FROM
      branches,
      itemtypes) branchitypes LEFT JOIN
  (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      Coalesce(items.itype, "XXX") AS itype,
      Coalesce(items.homebranch, "NEKLS") AS homebranch
    FROM
      items
    GROUP BY
      Coalesce(items.itype, "XXX"),
      Coalesce(items.homebranch, "NEKLS")) icounts ON icounts.itype = branchitypes.itemtype AND
      icounts.homebranch = branchitypes.branchcode
WHERE
  branchitypes.branchcode LIKE <<Choose your library|LBRANCH>> AND
  branchitypes.itemtype LIKE <<Choose an item type|LITYPES>>
GROUP BY
  branchitypes.branchname,
  branchitypes.description,
  icounts.Count_itemnumber



