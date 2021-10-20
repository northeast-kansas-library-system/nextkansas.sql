/*
R.003306

----------

Name: GHW - Total items at a librayr on the last day of last month
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-01-14 16:07:32
Modified on: 2020-01-14 16:07:32
Date last run: 2020-12-30 17:24:11

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
      Coalesce(items.homebranch, "NEKLS") AS homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
    GROUP BY
      Coalesce(items.homebranch, "NEKLS"),
      Coalesce(items.itype, "XXX")
    UNION
    SELECT
      Coalesce(deleteditems.homebranch, "NEKLS") AS homebranch,
      Coalesce(deleteditems.itype, "XXX") AS itype,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
      deleteditems.timestamp > AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
    GROUP BY
      Coalesce(deleteditems.homebranch, "NEKLS"),
      Coalesce(deleteditems.itype, "XXX")
  ) allitems
    ON allitems.homebranch = branchntypes.branchcode AND
      allitems.itype = branchntypes.itemtype
  LEFT JOIN (
    SELECT
      Coalesce(items.homebranch, "NEKLS") AS homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      items.location,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
      (items.location = 'ADULT' OR
        items.location = "LVPLADULT" OR
        items.location = "PAOLAADULT")
    GROUP BY
      Coalesce(items.homebranch, "NEKLS"),
      Coalesce(items.itype, "XXX"),
      items.location
    UNION
    SELECT
      Coalesce(deleteditems.homebranch, "NEKLS") AS homebranch,
      Coalesce(deleteditems.itype, "XXX") AS itype,
      deleteditems.location,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
      deleteditems.timestamp > AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
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
      Coalesce(items.homebranch, "NEKLS") AS homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      items.location,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
      (items.location = 'CHILDRENS' OR
        items.location = "LVPLCHILD" OR
        items.location = "PAOLACHILD")
    GROUP BY
      Coalesce(items.homebranch, "NEKLS"),
      Coalesce(items.itype, "XXX"),
      items.location
    UNION
    SELECT
      Coalesce(deleteditems.homebranch, "NEKLS") AS homebranch,
      Coalesce(deleteditems.itype, "XXX") AS itype,
      deleteditems.location,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
      deleteditems.timestamp > AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
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
      Coalesce(items.homebranch, "NEKLS") AS homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      items.location,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
      (items.location = 'YOUNGADULT' OR
        items.location = "LVPLYA" OR
        items.location = "PAOLAYA")
    GROUP BY
      Coalesce(items.homebranch, "NEKLS"),
      Coalesce(items.itype, "XXX"),
      items.location
    UNION
    SELECT
      Coalesce(deleteditems.homebranch, "NEKLS") AS homebranch,
      Coalesce(deleteditems.itype, "XXX") AS itype,
      deleteditems.location,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
      deleteditems.timestamp > AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
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
      Coalesce(items.homebranch, "NEKLS") AS homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      items.location,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
      (items.location = 'CART' OR
        items.location = "CATALOGING" OR
        items.location = "PROC" OR
        items.location = "" OR
        items.location IS NULL)
    GROUP BY
      Coalesce(items.homebranch, "NEKLS"),
      Coalesce(items.itype, "XXX"),
      items.location
    UNION
    SELECT
      Coalesce(deleteditems.homebranch, "NEKLS") AS homebranch,
      Coalesce(deleteditems.itype, "XXX") AS itype,
      deleteditems.location,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
      deleteditems.timestamp > AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
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

























