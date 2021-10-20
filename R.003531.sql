/*
R.003531

----------

Name: GHW - Item count by item type -and- collection code
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-07-26 12:32:27
Modified on: 2021-07-26 14:42:50
Date last run: 2021-07-26 14:34:22

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Count items by home library, item type, and collection code.</p>
<ul><li>Counts items at the time that the report is run</li>
<li>at the library you specify</li>
<li>grouped and sorted by item home library, item type, and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Gives an extreme amount of information on the collection at the library you specify.</p>
<p></p>
<p class= "notetags" style="display: none;">#countitems, item count, item type, collection code, itype, ccode, homebranch</p>
</div>


----------
*/



SELECT
  branchestypescodes.branchname,
  branchestypescodes.description AS "ITEM TYPE",
  branchestypescodes.lib AS "COLLECTION CODE",
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
      itemtypes.description,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      branches,
      itemtypes,
      authorised_values
    WHERE
      authorised_values.category = 'ccode') branchestypescodes LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      If(items.ccode IS NULL, "XXX", If(items.ccode = "", "XXX", items.ccode))
      AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype),
      If(items.ccode IS NULL, "XXX", items.ccode)) itemss ON itemss.homebranch =
      branchestypescodes.branchcode AND
      itemss.itype = branchestypescodes.itemtype AND
      itemss.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      If(items.ccode IS NULL, "XXX", If(items.ccode = "", "XXX", items.ccode))
      AS ccode,
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
      If(items.itype IS NULL, "XXX", items.itype),
      If(items.ccode IS NULL, "XXX", items.ccode)) adultitems ON
      adultitems.itype = branchestypescodes.itemtype AND
      adultitems.homebranch = branchestypescodes.branchcode AND
      adultitems.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      If(items.ccode IS NULL, "XXX", If(items.ccode = "", "XXX", items.ccode))
      AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE '%CHILD%'
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype),
      If(items.ccode IS NULL, "XXX", items.ccode)) juvenileitems ON
      juvenileitems.itype = branchestypescodes.itemtype AND
      juvenileitems.homebranch = branchestypescodes.branchcode AND
      juvenileitems.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      If(items.ccode IS NULL, "XXX", If(items.ccode = "", "XXX", items.ccode))
      AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE '%YA%'
    GROUP BY
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype),
      If(items.ccode IS NULL, "XXX", items.ccode)) yaitems ON
      yaitems.itype = branchestypescodes.itemtype AND
      yaitems.homebranch = branchestypescodes.branchcode AND
      yaitems.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
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
  items_added ON items_added.itype = branchestypescodes.itemtype AND
      items_added.homebranch = branchestypescodes.branchcode AND
      items_added.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
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
  adult_added ON adult_added.itype = branchestypescodes.itemtype AND
      adult_added.homebranch = branchestypescodes.branchcode AND
      adult_added.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      If(items.ccode IS NULL, "XXX", If(items.ccode = "", "XXX", items.ccode))
      AS ccode,
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
      juvenile_added.itype = branchestypescodes.itemtype AND
      juvenile_added.homebranch = branchestypescodes.branchcode AND
      juvenile_added.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      items.homebranch,
      If(items.itype IS NULL, "XXX", items.itype) AS itype,
      If(items.ccode IS NULL, "XXX", If(items.ccode = "", "XXX", items.ccode))
      AS ccode,
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
      ya_added.itype = branchestypescodes.itemtype AND
      ya_added.homebranch = branchestypescodes.branchcode AND
      ya_added.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", deleteditems.itype) AS itype,
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
      deleteditems.ccode))) items_deleted ON items_deleted.itype =
      branchestypescodes.itemtype AND
      items_deleted.homebranch = branchestypescodes.branchcode AND
      items_deleted.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", deleteditems.itype) AS itype,
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
      deleteditems.ccode))) adult_deleted ON adult_deleted.itype =
      branchestypescodes.itemtype AND
      adult_deleted.homebranch = branchestypescodes.branchcode AND
      adult_deleted.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", deleteditems.itype) AS itype,
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
      deleteditems.ccode))) juvenile_deleted ON juvenile_deleted.itype =
      branchestypescodes.itemtype AND
      juvenile_deleted.homebranch = branchestypescodes.branchcode AND
      juvenile_deleted.ccode = branchestypescodes.authorised_value LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      If(deleteditems.itype IS NULL, "XXX", deleteditems.itype) AS itype,
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
      deleteditems.ccode))) ya_deleted ON
      ya_deleted.itype = branchestypescodes.itemtype AND
      ya_deleted.homebranch = branchestypescodes.branchcode AND
      ya_deleted.ccode = branchestypescodes.authorised_value
WHERE
  branchestypescodes.branchcode LIKE <<Choose your library|branches>> AND
  branchestypescodes.itemtype LIKE <<Choose a specific item type|itemtypes:all>> AND
  branchestypescodes.authorised_value LIKE <<OR - choose a specific collection code|CCODE:all>>
GROUP BY
  branchestypescodes.branchname,
  branchestypescodes.description,
  branchestypescodes.lib
ORDER BY
  branchestypescodes.branchname,
  branchestypescodes.description,
  branchestypescodes.lib

























