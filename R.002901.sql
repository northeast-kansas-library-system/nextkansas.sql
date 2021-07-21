/*
R.002901

----------

Name: GHW - Materials added count by collection code and location - previous calendar month
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2017-02-07 15:03:15
Modified on: 2021-04-06 16:32:23
Date last run: 2021-07-07 14:21:43

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Count of items added by item home library and item collection code</p>
<ul><li>counts items added in the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped and sorted by item home branch, location, and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Updated on 2021.04.06</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2901&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  branch_ccode.branchname AS LIBRARY,
  branch_ccode.lib AS COLLECTION_CODE,
  Coalesce(itemsall.Count_itemnumber, 0) AS ADDED_LM_ALL,
  Coalesce(itemsadult.Count_itemnumber, 0) AS ADDED_LM_ADULT,
  Coalesce(itemsya.Count_itemnumber, 0) AS ADDED_LM_YA,
  Coalesce(itemchild.Count_itemnumber, 0) AS ADDED_LM_CHILD,
  Coalesce(itemsother.Count_itemnumber, 0) AS ADDED_LM_OTHER
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
      branches.branchcode LIKE <<Choose your library|ZBRAN>> AND
      authorised_values.category = 'CCODE') branch_ccode LEFT JOIN
  (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      Coalesce(items.homebranch, "NEKLS") AS homebranch,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      Coalesce(items.ccode, "XXX"),
      items.homebranch) itemsall ON
      itemsall.homebranch = branch_ccode.branchcode AND
      itemsall.ccode = branch_ccode.authorised_value LEFT JOIN
  (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      Coalesce(items.homebranch, "NEKLS") AS homebranch,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(items.permanent_location, "CART") = 'ADULT' OR
        Coalesce(items.permanent_location, "CART") = 'LVPLADULT' OR
        Coalesce(items.permanent_location, "CART") = 'PAOLAADULT' OR
        Coalesce(items.permanent_location, "CART") = 'BALDADULT')
    GROUP BY
      Coalesce(items.homebranch, "NEKLS"),
      Coalesce(items.ccode, "XXX")) itemsadult ON itemsadult.homebranch =
      branch_ccode.branchcode AND
      itemsadult.ccode = branch_ccode.authorised_value LEFT JOIN
  (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      Coalesce(items.homebranch, "NEKLS") AS homebranch,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(items.permanent_location, "CART") LIKE "%YA%" OR
        Coalesce(items.permanent_location, "CART") LIKE "YOUNGADULT")
    GROUP BY
      Coalesce(items.homebranch, "NEKLS"),
      Coalesce(items.ccode, "XXX")) itemsya ON itemsya.homebranch =
      branch_ccode.branchcode AND
      itemsya.ccode = branch_ccode.authorised_value LEFT JOIN
  (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      Coalesce(items.homebranch, "NEKLS") AS homebranch,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      Coalesce(items.permanent_location, "CART") LIKE "%CHILD%"
    GROUP BY
      Coalesce(items.homebranch, "NEKLS"),
      Coalesce(items.ccode, "XXX")) itemchild ON itemchild.homebranch =
      branch_ccode.branchcode AND
      itemchild.ccode = branch_ccode.authorised_value LEFT JOIN
  (SELECT
      Count(items.itemnumber) AS Count_itemnumber,
      Coalesce(items.homebranch, "NEKLS") AS homebranch,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      Coalesce(items.permanent_location, "CART") NOT LIKE "%ADULT%" AND
      Coalesce(items.permanent_location, "CART") NOT LIKE "%CHILD%" AND
      Coalesce(items.permanent_location, "CART") NOT LIKE "%YA%"
    GROUP BY
      Coalesce(items.homebranch, "NEKLS"),
      Coalesce(items.ccode, "XXX")) itemsother ON itemsother.homebranch =
      branch_ccode.branchcode AND
      itemsother.ccode = branch_ccode.authorised_value
GROUP BY
  branch_ccode.branchname,
  branch_ccode.lib
ORDER BY
  LIBRARY,
  COLLECTION_CODE



