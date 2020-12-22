/*
R.003139

----------

Name: GHW - Item count by library and collection code
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-12-07 21:59:03
Modified on: 2020-12-03 09:02:12
Date last run: 2020-12-03 09:02:43

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Gives a count of how many items are at the selected library based on collection code and Adult/Juvenile/YA shelving locations.</p>
<ul><li>Shows count at the time the report is run</li>
<li>on items at the library you specify</li>
<li>grouped and sorted by item home library and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>CART/CATALOGING/PROC locations are counted as "Adult" locations.</p>
<p>Items with blank collection codes are counted as "(Unclassified)."</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3139&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  branchccodes.branchcode,
  branchccodes.lib,
  itemss.Count_itemnumber AS TOTAL_ITEMS,
  adultitems.Count_itemnumber AS ADULT_ITEMS,
  juvenileitems.Count_itemnumber AS JUVENILE_ITEMS,
  yaitems.Count_itemnumber AS YOUNG_ADULT_ITEMS
FROM
  (SELECT
      branches.branchcode,
      authorised_values.authorised_value,
      authorised_values.lib
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
      (items.permanent_location = 'CHILDRENS' OR
          items.permanent_location = 'BALDCHILD' OR
          items.permanent_location = 'LVPLCHILD' OR
          items.permanent_location = 'PAOLACHILD')
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
      (items.permanent_location = 'YOUNGADULT' OR
          items.permanent_location = 'BALDYA' OR
          items.permanent_location = 'LVPLYA' OR
          items.permanent_location = 'PAOLAYA')
    GROUP BY
      items.homebranch,
      If(items.ccode IS NULL, "XXX", items.ccode)) yaitems ON
      yaitems.homebranch = branchccodes.branchcode AND
      yaitems.ccode = branchccodes.authorised_value
WHERE
  branchccodes.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branchccodes.branchcode,
  branchccodes.lib,
  itemss.Count_itemnumber,
  adultitems.Count_itemnumber,
  juvenileitems.Count_itemnumber,
  yaitems.Count_itemnumber



