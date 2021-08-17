/*
R.003139

----------

Name: GHW - Monthly Item count by library and collection code
Created by: George H Williams

----------

Group: Statistics
     -

Created on: 2018-12-07 21:59:03
Modified on: 2021-07-26 22:45:23
Date last run: 2021-07-26 22:44:13

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
<p>Updated 2021.07.23 to include counts from the previous month on deletions and additions.</p>
<p>This report cannot track changes made to existing records over time.  Therefore, if staff change the home library, location, or collection code of an item, those changes will not be reflected in the additions or deletions columns.  This means that the numbers may look inconsistent from month to month if changes are made to item records.</p>
<p class= "notetags" style="display: none;">#itemcount, item count collection code ccode #master #monthlystats #deletesoon</p>
</div>

----------
*/

SELECT
  branchccodes.branchname,
  branchccodes.lib AS "COLLECTION CODE",
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
      authorised_values.authorised_value,
      authorised_values.lib,
      branches.branchname
    FROM
      branches,
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') branchccodes LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) itemss ON itemss.homebranch =
      branchccodes.branchcode AND
      itemss.ccode = branchccodes.authorised_value LEFT JOIN
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
      adultitems.homebranch = branchccodes.branchcode AND
      adultitems.ccode = branchccodes.authorised_value LEFT JOIN
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
      juvenileitems.homebranch = branchccodes.branchcode AND
      juvenileitems.ccode = branchccodes.authorised_value LEFT JOIN
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
      yaitems.homebranch = branchccodes.branchcode AND
      yaitems.ccode = branchccodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", If(items.ccode = "", "XXX", items.ccode))
      AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", If(items.ccode = "", "XXX", items.ccode)))
  items_added ON items_added.homebranch = branchccodes.branchcode AND
      items_added.ccode = branchccodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.ccode IS NULL, "XXX", If(items.ccode = "", "XXX", items.ccode))
      AS ccode,
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
        items.permanent_location IS NULL OR
        items.permanent_location = "")
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", If(items.ccode = "", "XXX", items.ccode)))
  adult_added ON adult_added.homebranch = branchccodes.branchcode AND
      adult_added.ccode = branchccodes.authorised_value LEFT JOIN
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
      juvenile_added.homebranch = branchccodes.branchcode AND
      juvenile_added.ccode = branchccodes.authorised_value LEFT JOIN
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
      ya_added.homebranch = branchccodes.branchcode AND
      ya_added.ccode = branchccodes.authorised_value LEFT JOIN
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
      branchccodes.branchcode AND
      items_deleted.ccode = branchccodes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode)) AS ccode,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      (deleteditems.permanent_location LIKE '%ADULT%' OR
        deleteditems.permanent_location = 'CART' OR
        deleteditems.permanent_location = 'CATALOGING' OR
        deleteditems.permanent_location = 'PROC' OR
        deleteditems.permanent_location IS NULL OR
        deleteditems.permanent_location = "")
    GROUP BY
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode))) adult_deleted ON adult_deleted.homebranch =
      branchccodes.branchcode AND
      adult_deleted.ccode = branchccodes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode)) AS ccode,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      deleteditems.permanent_location LIKE '%CHILD%'
    GROUP BY
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode))) juvenile_deleted ON juvenile_deleted.homebranch =
      branchccodes.branchcode AND
      juvenile_deleted.ccode = branchccodes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode)) AS ccode,
      Count(deleteditems.itemnumber) AS Count_itemnumber
    FROM
      deleteditems
    WHERE
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      deleteditems.permanent_location LIKE '%YA%'
    GROUP BY
      deleteditems.homebranch,
      If(deleteditems.ccode IS NULL, "XXX", If(deleteditems.ccode = "", "XXX",
      deleteditems.ccode))) ya_deleted ON ya_deleted.homebranch =
      branchccodes.branchcode AND
      ya_deleted.ccode = branchccodes.authorised_value
GROUP BY
  branchccodes.branchcode,
  branchccodes.authorised_value
ORDER BY
  branchccodes.branchname,
  branchccodes.lib



