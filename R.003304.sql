/*
R.003304

----------

Name: GHW - Item Count by item type
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-01-13 16:10:56
Modified on: 2021-07-22 09:50:51
Date last run: 2022-08-30 10:39:02

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
      itemtypes
    GROUP BY
      branches.branchcode,
      branches.branchname,
      itemtypes.itemtype,
      itemtypes.description) branchtypes LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS ITYPE,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch,
      Coalesce(items.itype, "XXX")) itemss ON itemss.homebranch =
      branchtypes.branchcode AND
      itemss.ITYPE = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      (items.permanent_location = 'ADULT' OR
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
      items.permanent_location LIKE "%CHILD%"
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
      (items.permanent_location LIKE "YOUNGADULT" OR
        items.permanent_location LIKE "%YA%")
    GROUP BY
      items.homebranch,
      Coalesce(items.itype, "XXX")) yaitems ON yaitems.homebranch =
      branchtypes.branchcode AND
      yaitems.itype = branchtypes.itemtype
WHERE
  branchtypes.branchcode LIKE <<Choose your library|LBRANCH>> AND
  branchtypes.itemtype LIKE <<Choose an item type|LITYPES>>
GROUP BY
  branchtypes.branchcode,
  branchtypes.description,
  itemss.Count_itemnumber,
  adultitems.Count_itemnumber,
  juvenileitems.Count_itemnumber,
  yaitems.Count_itemnumber

























