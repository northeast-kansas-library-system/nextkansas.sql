/*
R.003180

----------

Name: GHW - CCODE count by library
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-02-27 21:24:58
Modified on: 2019-02-27 21:51:12
Date last run: 2020-12-16 22:55:44

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Counts items at a library based on collection code and shelving location</p>
<ul><li>Shows items added before a certain date - but will not count items that have already been deleted</li>
<li>at the library you specify</li>
<li>grouped and sorted by branch code and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report is not designed to count items that have already been deleted.</p>
<p></p
<p>Items without collection code information are counted as (Unclassified).  Items without a shelving locations are counted in the "Other" column.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3180&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  branchncodes.branchcode,
  branchncodes.lib,
  totalitems.Count_itemnumber AS TOTAL,
  adultitems.Count_itemnumber AS ADULT,
  yaitems.Count_itemnumber AS YOUNG_ADULT,
  childitems.Count_itemnumber AS CHILDRENS,
  otheritems.Count_itemnumber AS OTHER
FROM
  (SELECT
      branches.branchname,
      branches.branchcode,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      branches,
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      branches.branchname,
      branches.branchcode,
      authorised_values.authorised_value,
      authorised_values.lib) branchncodes
  LEFT JOIN (SELECT
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber,
      items.homebranch
    FROM
      items
    WHERE
      items.dateaccessioned < @adate := <<Added before|date>> COLLATE utf8mb4_unicode_ci
    GROUP BY
      If(items.ccode IS NULL, "XXX", items.ccode),
      items.homebranch) totalitems ON totalitems.homebranch = branchncodes.branchcode AND
    totalitems.ccode = branchncodes.authorised_value
  LEFT JOIN (SELECT
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber,
      items.homebranch
    FROM
      items
    WHERE
      (items.location = 'ADULT' OR
        items.location = 'LVPLADULT') AND
      items.dateaccessioned < @adate
    GROUP BY
      If(items.ccode IS NULL, "XXX", items.ccode),
      items.homebranch) adultitems ON adultitems.homebranch = branchncodes.branchcode AND
    adultitems.ccode = branchncodes.authorised_value
  LEFT JOIN (SELECT
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber,
      items.homebranch
    FROM
      items
    WHERE
      (items.location = 'YOUNGADULT' OR
        items.location = 'LVPLYA') AND
      items.dateaccessioned < @adate
    GROUP BY
      If(items.ccode IS NULL, "XXX", items.ccode),
      items.homebranch) yaitems ON yaitems.homebranch = branchncodes.branchcode AND
    yaitems.ccode = branchncodes.authorised_value
  LEFT JOIN (SELECT
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber,
      items.homebranch
    FROM
      items
    WHERE
      (items.location = 'CHILDRENS' OR
        items.location = 'LVPLCHILD') AND
      items.dateaccessioned < @adate
    GROUP BY
      If(items.ccode IS NULL, "XXX", items.ccode),
      items.homebranch) childitems ON childitems.homebranch = branchncodes.branchcode AND
    childitems.ccode = branchncodes.authorised_value
  LEFT JOIN (SELECT
      If(items.ccode IS NULL, "XXX", items.ccode) AS ccode,
      Count(items.itemnumber) AS Count_itemnumber,
      items.homebranch
    FROM
      items
    WHERE
      ((items.location IS NULL OR
        items.location = "") AND
      items.dateaccessioned < @adate) OR
      (items.location <> 'LVPLADULT' AND
      items.location <> 'LVPLCHILD' AND
      items.location <> 'LVPLYA' AND
      items.location <> 'ADULT' AND
      items.location <> 'YOUNGADULT' AND
      items.location <> 'CHILDRENS' AND
      items.dateaccessioned < '2019-01-01')
    GROUP BY
      If(items.ccode IS NULL, "XXX", items.ccode),
      items.homebranch) otheritems ON otheritems.homebranch = branchncodes.branchcode AND
    otheritems.ccode = branchncodes.authorised_value
WHERE
  branchncodes.branchcode LIKE <<Choose your library|LBRANCH>>
GROUP BY
  branchncodes.branchcode,
  branchncodes.lib
ORDER BY
  branchncodes.branchcode,
  branchncodes.lib



