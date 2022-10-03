/*
R.002902

----------

Name: GHW - Materials added count by item type and permanent location - previous calendar month
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2017-02-07 15:12:53
Modified on: 2022-02-10 10:40:02
Date last run: 2022-06-07 15:20:28

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Count of items at your library by item type</p>
<ul><li>counts items by item type</li>
<li>at the library you specify</li>
<li>grouped and sorted by home branch, location, and item type</li>
<li>includes totals added and deleted in the previous calendar month</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Updated on February 20, 2022</p>
</div>

----------
*/



SELECT
  branchtypes.branchname,
  branchtypes.description AS "ITEM TYPE",
  Sum(itemss.Count_itemnumber) AS "TOTAL ITEMS",
  Sum(adultitems.Count_itemnumber) AS "ADULT ITEMS",
  Sum(yaitems.Count_itemnumber) AS "YOUNG ADULT ITEMS",
  Sum(juvenileitems.Count_itemnumber) AS "JUVENILE ITEMS",
  Sum(items_added.Count_itemnumber) AS "TOTAL ADDED LM",
  Sum(adult_added.Count_itemnumber) AS "ADULT ADDED LM",
  Sum(ya_added.Count_itemnumber) AS "YOUNG ADULT ADDED LM",
  Sum(juvenile_added.Count_itemnumber) AS "JUVENILE ADDED LM",
  Sum(items_deleted.Count_itemnumber) AS "TOTAL DELETED LM",
  Sum(adult_deleted.Count_itemnumber) AS "ADULT DELETED LM",
  Sum(ya_deleted.Count_itemnumber) AS "YOUNG ADULT DELETED LM",
  Sum(juvenile_deleted.Count_itemnumber) AS "JUVENILE DELETED LM"
FROM
  (
    SELECT
      branches.branchcode,
      branches.branchname,
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes,
      branches
    WHERE
      branches.branchcode LIKE <<Choose your library|ZBRAN>>
  ) branchtypes LEFT JOIN
  (
    SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)
  ) itemss ON itemss.homebranch = branchtypes.branchcode AND
      itemss.itype = branchtypes.itemtype LEFT JOIN
  (
    SELECT
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
      If(items.itype IS NULL, "XXX", items.itype)
  ) adultitems ON adultitems.homebranch = branchtypes.branchcode AND
      adultitems.itype = branchtypes.itemtype LEFT JOIN
  (
    SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE "%CHILD%"
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)
  ) juvenileitems ON juvenileitems.homebranch = branchtypes.branchcode AND
      juvenileitems.itype = branchtypes.itemtype LEFT JOIN
  (
    SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE "%YA%"
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype)
  ) yaitems ON yaitems.homebranch = branchtypes.branchcode AND
      yaitems.itype = branchtypes.itemtype LEFT JOIN
  (
    SELECT
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
      If(items.itype IS NULL, "XXX", items.itype)
  ) items_added ON items_added.homebranch = branchtypes.branchcode AND
      items_added.itype = branchtypes.itemtype LEFT JOIN
  (
    SELECT
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
      If(items.itype IS NULL, "XXX", items.itype)
  ) adult_added ON adult_added.homebranch = branchtypes.branchcode AND
      adult_added.itype = branchtypes.itemtype LEFT JOIN
  (
    SELECT
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
      If(items.itype IS NULL, "XXX", items.itype)
  ) juvenile_added ON juvenile_added.homebranch = branchtypes.branchcode AND
      juvenile_added.itype = branchtypes.itemtype LEFT JOIN
  (
    SELECT
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
      If(items.itype IS NULL, "XXX", items.itype)
  ) ya_added ON ya_added.homebranch = branchtypes.branchcode AND
      ya_added.itype = branchtypes.itemtype LEFT JOIN
  (
    SELECT
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
      deleteditems.itype))
    ) items_deleted ON items_deleted.homebranch = branchtypes.branchcode AND
      items_deleted.ccode = branchtypes.itemtype LEFT JOIN
  (
    SELECT
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
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX", deleteditems.itype))
  ) adult_deleted ON adult_deleted.homebranch = branchtypes.branchcode AND
      adult_deleted.ccode = branchtypes.itemtype LEFT JOIN
  (
    SELECT
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
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX", deleteditems.itype))
  ) juvenile_deleted ON juvenile_deleted.homebranch = branchtypes.branchcode AND
      juvenile_deleted.ccode = branchtypes.itemtype LEFT JOIN
  (
    SELECT
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
      If(deleteditems.itype IS NULL, "XXX", If(deleteditems.itype = "", "XXX", deleteditems.itype))
  ) ya_deleted ON ya_deleted.homebranch = branchtypes.branchcode AND
      ya_deleted.ccode = branchtypes.itemtype
GROUP BY
  branchtypes.branchname,
  branchtypes.description
ORDER BY
  branchtypes.branchname,
  "ITEM TYPE"

























