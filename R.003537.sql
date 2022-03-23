/*
R.003537

----------

Name: GHW - F1 Items and holdings statistics - item count by collection code - Next Search Catalog
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2021-07-29 16:35:30
Modified on: 2022-03-10 17:22:07
Date last run: 2022-03-10 17:13:38

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Gives a count of how many items are at the selected library based on collection code and Adult/Juvenile/YA permanent shelving locations.</p>
<ul><li>Shows count at the time the report is run</li>
<li>for all items system-wide</li>
<li>grouped and sorted by item home library and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Non-standard shelving locations are counted as "Adult" locations.</p>
<p>Items with blank collection codes are counted as "(Unclassified)."</p>
<p></p>
<p>This report cannot track changes made to existing records over time.  Therefore, if staff change the home library, location, or collection code of an item, those changes will not be reflected in the additions or deletions columns.  This means that the numbers may look inconsistent from month to month if changes are made to item records.</p>
</div>

----------
*/



SELECT
  branchtypes.branchname,
  branchtypes.lib AS `"COLLECTION CODE"`,
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
  (SELECT
      branches.branchcode,
      branches.branchname,
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      branches,
      authorised_values
    WHERE
      branches.branchcode LIKE '%' AND
      authorised_values.category = 'CCODE') branchtypes LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) itemss ON itemss.homebranch =
      branchtypes.branchcode AND
      itemss.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
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
      If(items.ccode IS NULL, "XXX", items.ccode)) adultitems ON
      adultitems.homebranch = branchtypes.branchcode AND
      adultitems.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE "%CHILD%"
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) juvenileitems ON
      juvenileitems.homebranch = branchtypes.branchcode AND
      juvenileitems.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE "%YA%"
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) yaitems ON
      yaitems.homebranch = branchtypes.branchcode AND
      yaitems.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) items_added ON
      items_added.homebranch = branchtypes.branchcode AND
      items_added.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
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
      If(items.ccode IS NULL, "XXX", items.ccode)) adult_added ON
      adult_added.homebranch = branchtypes.branchcode AND
      adult_added.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      items.permanent_location LIKE "%CHILD%"
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) juvenile_added ON
      juvenile_added.homebranch = branchtypes.branchcode AND
      juvenile_added.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      items.permanent_location LIKE "%YA%"
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) ya_added ON
      ya_added.homebranch = branchtypes.branchcode AND
      ya_added.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode)) AS ccode,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode))) items_deleted ON items_deleted.homebranch =
      branchtypes.branchcode AND
      items_deleted.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode)) AS ccode,
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
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode))) adult_deleted ON adult_deleted.homebranch =
      branchtypes.branchcode AND
      adult_deleted.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode)) AS ccode,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      deleteditems.permanent_location LIKE "%CHILD%"
    GROUP BY
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode))) juvenile_deleted ON juvenile_deleted.homebranch =
      branchtypes.branchcode AND
      juvenile_deleted.ccode = branchtypes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode)) AS ccode,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      deleteditems.permanent_location LIKE "%YA%"
    GROUP BY
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode))) ya_deleted ON ya_deleted.homebranch =
      branchtypes.branchcode AND
      ya_deleted.ccode = branchtypes.authorised_value
GROUP BY
  branchtypes.branchname,
  branchtypes.lib
ORDER BY
  branchtypes.branchname

























