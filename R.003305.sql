/*
R.003305

----------

Name: GHW - items deleted last month by itype
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-01-14 16:06:38
Modified on: 2020-01-14 16:06:38
Date last run: 2021-09-07 11:23:05

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branchntypes.branchname,
  branchntypes.description,
  Sum(DISTINCT allitems.Count_itemnumber) AS ALL_ITEMS,
  Sum(DISTINCT adult.Count_itemnumber) AS ADULT,
  Sum(DISTINCT childrens.Count_itemnumber) AS CHILDREN,
  Sum(DISTINCT ya.Count_itemnumber) AS YA,
  Sum(DISTINCT other.Count_itemnumber) AS OTHER
FROM
  (
    SELECT
      branches.branchname,
      branches.branchcode,
      itemtypes.itemtype,
      itemtypes.description
    FROM
      branches,
      itemtypes
    GROUP BY
      branches.branchname,
      branches.branchcode,
      itemtypes.itemtype,
      itemtypes.description
  ) branchntypes
  LEFT JOIN (
    SELECT
      Coalesce(deleteditems.homebranch, "NEKLS") AS homebranch,
      Coalesce(deleteditems.itype, "XXX") AS itype,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      Coalesce(deleteditems.homebranch, "NEKLS"),
      Coalesce(deleteditems.itype, "XXX")
  ) allitems
    ON allitems.homebranch = branchntypes.branchcode AND
      allitems.itype = branchntypes.itemtype
  LEFT JOIN (
    SELECT
      Coalesce(deleteditems.homebranch, "NEKLS") AS homebranch,
      Coalesce(deleteditems.itype, "XXX") AS itype,
      deleteditems.location,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      (deleteditems.location = 'ADULT' OR
        deleteditems.location = "LVPLADULT" OR
        deleteditems.location = "PAOLAADULT")
    GROUP BY
      Coalesce(deleteditems.homebranch, "NEKLS"),
      Coalesce(deleteditems.itype, "XXX"),
      deleteditems.location
  ) adult
    ON adult.homebranch = branchntypes.branchcode AND
      adult.itype = branchntypes.itemtype
  LEFT JOIN (
    SELECT
      Coalesce(deleteditems.homebranch, "NEKLS") AS homebranch,
      Coalesce(deleteditems.itype, "XXX") AS itype,
      deleteditems.location,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      (deleteditems.location = 'CHILDRENS' OR
        deleteditems.location = "LVPLCHILD" OR
        deleteditems.location = "PAOLACHILD")
    GROUP BY
      Coalesce(deleteditems.homebranch, "NEKLS"),
      Coalesce(deleteditems.itype, "XXX"),
      deleteditems.location
  ) childrens
    ON childrens.homebranch = branchntypes.branchcode AND
      childrens.itype = branchntypes.itemtype
  LEFT JOIN (
    SELECT
      Coalesce(deleteditems.homebranch, "NEKLS") AS homebranch,
      Coalesce(deleteditems.itype, "XXX") AS itype,
      deleteditems.location,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      (deleteditems.location = 'YOUNGADULT' OR
        deleteditems.location = "LVPLYA" OR
        deleteditems.location = "PAOLAYA")
    GROUP BY
      Coalesce(deleteditems.homebranch, "NEKLS"),
      Coalesce(deleteditems.itype, "XXX"),
      deleteditems.location
  ) ya
    ON ya.homebranch = branchntypes.branchcode AND
      ya.itype = branchntypes.itemtype
  LEFT JOIN (
    SELECT
      Coalesce(deleteditems.homebranch, "NEKLS") AS homebranch,
      Coalesce(deleteditems.itype, "XXX") AS itype,
      deleteditems.location,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      (deleteditems.location = 'CART' OR
        deleteditems.location = "CATALOGING" OR
        deleteditems.location = "PROC" OR
        deleteditems.location = "" OR
        deleteditems.location IS NULL)
    GROUP BY
      Coalesce(deleteditems.homebranch, "NEKLS"),
      Coalesce(deleteditems.itype, "XXX"),
      deleteditems.location
  ) other
    ON other.homebranch = branchntypes.branchcode AND
      other.itype = branchntypes.itemtype
WHERE
  branchntypes.branchcode = 'CORNING'
GROUP BY
  branchntypes.branchname,
  branchntypes.description

























