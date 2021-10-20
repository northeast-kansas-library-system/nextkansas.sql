/*
R.003530

----------

Name: GHW - Monthly 410 Item count by library and item type
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2021-07-26 11:25:35
Modified on: 2021-07-30 10:54:22
Date last run: 2021-10-01 00:33:02

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Gives a count of how many items are at the selected library based on item type and Adult/Juvenile/YA permanent shelving locations.</p>
<ul><li>Shows count at the time the report is run</li>
<li>for all items system-wide</li>
<li>grouped and sorted by item home library and item type</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Non-standard shelving locations are counted as "Adult" locations.</p>
<p>Items with blank item types are counted as "(Unclassified)."</p>
<p></p>
<p>This report cannot track changes made to existing records over time.  Therefore, if staff change the home library, location, or item type of an item, those changes will not be reflected in the additions or deletions columns.  This means that the numbers may look inconsistent from month to month if changes are made to item records.</p>
</div>

----------
*/



SELECT
  branchtypes.branchname,
  branchtypes.description AS "ITEM TYPE",
  itemss.Count_itemnumber AS "TOTAL ITEMS",
  adultitems.Count_itemnumber AS "ADULT ITEMS",
  juvenileitems.Count_itemnumber AS "JUVENILE ITEMS",
  yaitems.Count_itemnumber AS "YOUNG ADULT ITEMS",
  items_added.Count_itemnumber AS "TOTAL ADDED LM",
  adult_added.Count_itemnumber AS "ADULT ADDED LM",
  juvenile_added.Count_itemnumber AS "JUVENILE ADDED LM",
  ya_added.Count_itemnumber AS "YOUNG ADULT ADDED LM",
  items_deleted.Count_itemnumber AS "TOTAL DELETED LM",
  adult_deleted.Count_itemnumber AS "ADULT DELETED LM",
  juvenile_deleted.Count_itemnumber AS "JUVENILE DELETED LM",
  ya_deleted.Count_itemnumber AS "YOUNG ADULT DELETED LM"
FROM
  (SELECT
      branches.branchcode,
      branches.branchname,
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes,
      branches) branchtypes LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)) itemss ON itemss.homebranch =
      branchtypes.branchcode AND
      itemss.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      (items.permanent_location LIKE '%ADULT%' OR
        items.permanent_location = 'CART' OR
        items.permanent_location = 'CATALOGING' OR
        items.permanent_location = 'PROC' OR
        items.permanent_location IS NULL)
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)) adultitems ON
      adultitems.homebranch = branchtypes.branchcode AND
      adultitems.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE "%CHILD%"
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)) juvenileitems ON
      juvenileitems.homebranch = branchtypes.branchcode AND
      juvenileitems.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE "%YA%"
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)) yaitems ON
      yaitems.homebranch = branchtypes.branchcode AND
      yaitems.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)) items_added ON
      items_added.homebranch = branchtypes.branchcode AND
      items_added.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      (items.permanent_location LIKE '%ADULT%' OR
        items.permanent_location = 'CART' OR
        items.permanent_location = 'CATALOGING' OR
        items.permanent_location = 'PROC' OR
        items.permanent_location IS NULL)
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)) adult_added ON
      adult_added.homebranch = branchtypes.branchcode AND
      adult_added.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      items.permanent_location LIKE "%CHILD%"
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)) juvenile_added ON
      juvenile_added.homebranch = branchtypes.branchcode AND
      juvenile_added.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      items.permanent_location LIKE "%YA%"
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)) ya_added ON
      ya_added.homebranch = branchtypes.branchcode AND
      ya_added.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX",
      deleteditems.itype)) AS ccode,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX",
      deleteditems.itype))) items_deleted ON items_deleted.homebranch =
      branchtypes.branchcode AND
      items_deleted.ccode = branchtypes.itemtype LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX",
      deleteditems.itype)) AS ccode,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      (deleteditems.permanent_location LIKE '%ADULT%' OR
        deleteditems.permanent_location = 'CART' OR
        deleteditems.permanent_location = 'CATALOGING' OR
        deleteditems.permanent_location = 'PROC' OR
        deleteditems.permanent_location IS NULL)
    GROUP BY
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX",
      deleteditems.itype))) adult_deleted ON adult_deleted.homebranch =
      branchtypes.branchcode AND
      adult_deleted.ccode = branchtypes.itemtype LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX",
      deleteditems.itype)) AS ccode,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      deleteditems.permanent_location LIKE "%CHILD%"
    GROUP BY
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX",
      deleteditems.itype))) juvenile_deleted ON juvenile_deleted.homebranch =
      branchtypes.branchcode AND
      juvenile_deleted.ccode = branchtypes.itemtype LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX",
      deleteditems.itype)) AS ccode,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      deleteditems.permanent_location LIKE "%YA%"
    GROUP BY
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX",
      deleteditems.itype))) ya_deleted ON ya_deleted.homebranch =
      branchtypes.branchcode AND
      ya_deleted.ccode = branchtypes.itemtype
GROUP BY
  branchtypes.branchname,
  branchtypes.description
ORDER BY
  branchtypes.branchname,
  branchtypes.description

























