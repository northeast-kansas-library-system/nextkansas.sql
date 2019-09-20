/*
R.002901

----------

Name: GHW - Materials added count by collection code and location - previous calendar month
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2017-02-07 15:03:15
Modified on: 2019-01-28 01:18:58
Date last run: 2019-09-12 09:50:29

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Count of items added by location and item collection code</p>
<ul><li>counts items added in the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped and sorted by item home branch, location, and collection code</li>
<li>includes total for the month at the bottom of the results</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2901&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  branch_ccode.branchname,
  branch_ccode.lib,
  Coalesce(itemsall.Count_itemnumber, 0) AS COUNT_ALL,
  Coalesce(itemsadult.Count_itemnumber, 0) AS COUNT_ADULT,
  Coalesce(itemsya.Count_itemnumber, 0) AS COUNT_YA,
  Coalesce(itemchild.Count_itemnumber, 0) AS COUNT_CHILD,
  Coalesce(itemsother.Count_itemnumber, 0) AS COUNT_OTHER
FROM
  (SELECT
      branches.branchname,
      branches.branchcode,
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      branches,
      authorised_values
    WHERE
      branches.branchcode LIKE <<Choose your library|LBRANCH>> AND
      authorised_values.category = 'CCODE') branch_ccode
  LEFT JOIN (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      items.homebranch,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      items.homebranch,
      Coalesce(items.ccode, "XXX")) itemsall ON itemsall.homebranch = branch_ccode.branchcode AND
    itemsall.ccode = branch_ccode.authorised_value
  LEFT JOIN (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      items.homebranch,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(items.location, "CART") = 'ADULT' OR
        Coalesce(items.location, "CART") = 'LVPLADULT')
    GROUP BY
      items.homebranch,
      Coalesce(items.ccode, "XXX")) itemsadult ON itemsadult.homebranch = branch_ccode.branchcode AND
    itemsadult.ccode = branch_ccode.authorised_value
  LEFT JOIN (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      items.homebranch,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(items.location, "CART") = 'YOUNGADULT' OR
        Coalesce(items.location, "CART") = 'LVPLYA')
    GROUP BY
      items.homebranch,
      Coalesce(items.ccode, "XXX")) itemsya ON itemsya.homebranch = branch_ccode.branchcode AND
    itemsya.ccode = branch_ccode.authorised_value
  LEFT JOIN (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      items.homebranch,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(items.location, "CART") = 'CHILDRENS' OR
        Coalesce(items.location, "CART") = 'LVPLCHILD')
    GROUP BY
      items.homebranch,
      Coalesce(items.ccode, "XXX")) itemchild ON itemchild.homebranch = branch_ccode.branchcode AND
    itemchild.ccode = branch_ccode.authorised_value
  LEFT JOIN (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      items.homebranch,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      Coalesce(items.location, "CART") <> 'ADULT' AND
      Coalesce(items.location, "CART") <> 'LVPLADULT' AND
      Coalesce(items.location, "CART") <> 'YOUNGADULT' AND
      Coalesce(items.location, "CART") <> 'LVPLYA' AND
      Coalesce(items.location, "CART") <> 'CHILDRENS' AND
      Coalesce(items.location, "CART") <> 'LVPLCHILD'
    GROUP BY
      items.homebranch,
      Coalesce(items.ccode, "XXX")) itemsother ON itemsother.homebranch = branch_ccode.branchcode AND
    itemsother.ccode = branch_ccode.authorised_value
GROUP BY
  branch_ccode.branchname,
  branch_ccode.lib
ORDER BY
  branch_ccode.branchname



