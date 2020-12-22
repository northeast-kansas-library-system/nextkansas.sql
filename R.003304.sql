/*
R.003304

----------

Name: GHW - Item Count by item type
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-01-13 16:10:56
Modified on: 2020-12-03 12:17:32
Date last run: 2020-12-03 12:19:34

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branchtypes.branchcode,
  branchtypes.description AS ITEM_TYPE,
  itemss.Count_itemnumber AS TOTAL_ITEMS,
  adultitems.Count_itemnumber AS ADULT_ITEMS,
  juvenileitems.Count_itemnumber AS JUVENILE_ITEMS,
  yaitems.Count_itemnumber AS YOUNG_ADULT_ITEMS
FROM
  (SELECT
      branches.branchcode,
      branches.branchname,
      itemtypes.itemtype,
      itemtypes.description
    FROM
      branches,
      itemtypes) branchtypes LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS ITYPE,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch) itemss ON itemss.homebranch = branchtypes.branchcode AND
      itemss.ITYPE = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      (items.location = 'ADULT' OR
          items.permanent_location = 'BALDADULT' OR
          items.permanent_location = 'LVPLADULT' OR
          items.permanent_location = 'PAOLAADULT' OR
          items.permanent_location = 'CART' OR
          items.permanent_location = 'CATALOGING' OR
          items.permanent_location = 'PROC' OR
          items.permanent_location IS NULL)
    GROUP BY
      items.homebranch,
      Coalesce(items.itype, "XXX")) adultitems ON adultitems.homebranch =
      branchtypes.branchcode AND
      adultitems.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      (items.permanent_location = 'CHILDRENS' OR
          items.permanent_location = 'BALDCHILD' OR
          items.permanent_location = 'LVPLCHILD' OR
          items.permanent_location = 'PAOLACHILD')
    GROUP BY
      items.homebranch,
      Coalesce(items.itype, "XXX")) juvenileitems ON juvenileitems.homebranch =
      branchtypes.branchcode AND
      juvenileitems.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      (items.permanent_location = 'YOUNGADULT' OR
          items.permanent_location = 'BALDYA' OR
          items.permanent_location = 'LVPLYA' OR
          items.permanent_location = 'PAOLAYA')
    GROUP BY
      items.homebranch,
      Coalesce(items.itype, "XXX")) yaitems ON yaitems.homebranch =
      branchtypes.branchcode AND
      yaitems.itype = branchtypes.itemtype
WHERE
  branchtypes.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branchtypes.branchcode,
  branchtypes.description,
  itemss.Count_itemnumber,
  adultitems.Count_itemnumber,
  juvenileitems.Count_itemnumber,
  yaitems.Count_itemnumber



