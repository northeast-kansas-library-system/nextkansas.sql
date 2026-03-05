/*
R.003484

----------

Name: GHW- Turnover by location and collection code
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-17 22:51:30
Modified on: 2024-01-17 12:00:28
Date last run: 2024-01-23 12:49:07

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows turnover rate by location and collection code&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;in the previous 12 months&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped by library, location, and collection code&lt;/li&gt;
&lt;li&gt;sorted by library, location, and collection code with an "All locations" and "All collection codes" grouping at the top of the results&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Developed for "Collection development 2.0" workshop&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Please note that these calculations include all items checked out at your library regardless of which library owned the item.  If, for example, your library doesn't own any items with a "VG-Nintendo 3DS" collection code but one from another library was checked out at your library to fill a request, that item will be counted in these calculations.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;"CURRENT_ITEM_COUNT" is based on an item's collection code at the time the report was run.  "CKO_RENEW_COUNT" is based on an item's collection code at the time it was checked out.  It an item's collection code changes between the time it was checked out and the time this report is run, the results will be skewed.  This can be particularly true with temporary items such as ILL items.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3484&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;statistics, turnover, previous 12 months&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat("Today's date:") AS branchcode,
  CURRENT_DATE() AS LOCATION,
  Concat('Start date:') AS CCODE,
  (AddDate(Last_Day(SubDate(Now(), INTERVAL 13 MONTH)),
  1)) AS CURRENT_ITEM_COUNT,
  Concat('End date:') AS CKO_RENEW_COUNT,
  ((AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)) - INTERVAL
  1 DAY) AS TURNOVER
UNION
SELECT
  Concat("-") AS branchcode,
  Concat("-") AS LOCATION,
  Concat("-") AS CCODE,
  Concat("-") AS CURRENT_ITEM_COUNT,
  Concat("-") AS CKO_RENEW_COUNT,
  Concat("-") AS TURNOVER
UNION
SELECT
  branchess.branchcode,
  Concat("All locations") AS LOCATION,
  Concat("All collection codes") AS CCODE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT,
  round((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
FROM
  (SELECT
     branches.branchcode
   FROM
     branches
   GROUP BY
     branches.branchcode) branchess LEFT JOIN
  (SELECT
     items.homebranch,
     Count(items.itemnumber) AS Count_itemnumber
   FROM
     items
   GROUP BY
     items.homebranch) icounts ON icounts.homebranch = branchess.branchcode
  LEFT JOIN
  (SELECT
     If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
     count(&ast;) AS COUNT
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     statistics.datetime BETWEEN (AddDate(Last_Day(SubDate(Now(), INTERVAL 13
     MONTH)), 1)) AND (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
   GROUP BY
     If(statistics.branch IS NULL, "NEKLS", statistics.branch)) statcounts ON
      statcounts.branch = branchess.branchcode
WHERE
  branchess.branchcode LIKE &lt;&gt;
GROUP BY
  branchess.branchcode,
  icounts.Count_itemnumber,
  statcounts.COUNT
UNION
SELECT
  Concat('--') AS branchcode,
  Concat('--') AS LOCATION,
  Concat('--') AS CCODE,
  Concat('--') AS CURRENT_ITEM_COUNT,
  Concat('--') AS CKO_RENEW_COUNT,
  Concat('--') AS TURNOVER
UNION
SELECT
  branchess.branchcode,
  branchess.lib AS LOCATION,
  Concat("All collection codes") AS CCODE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT,
  round((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
FROM
  (SELECT
     branches.branchcode,
     biblocs.authorised_value,
     biblocs.lib
   FROM
     branches,
     (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'bibloc' AND
        authorised_values.authorised_value &lt;&gt; "YOUNGADULT") biblocs) branchess
  LEFT JOIN
  (SELECT
     items.homebranch,
     If(items.permanent_location = "BALDADULT", "ADULT",
       If(items.permanent_location = "LVPLADULT", "ADULT",
         If(items.permanent_location = "PAOLAADULT", "ADULT",
           If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
             If(items.permanent_location LIKE "%Y%", "L_YA", 
               If(items.permanent_location LIKE "%CA%", "ADULT", 
                 If(items.permanent_location LIKE "%PROC%", "ADULT",
                   If(items.permanent_location IS NULL, "ADULT",
                     items.permanent_location
                   )
                 )
               )
             )
           )
         )
       )
     ) AS permanent_location,
     Count(items.itemnumber) AS Count_itemnumber
   FROM
     items
   GROUP BY
     items.homebranch,
     If(items.permanent_location = "BALDADULT", "ADULT",
       If(items.permanent_location = "LVPLADULT", "ADULT",
         If(items.permanent_location = "PAOLAADULT", "ADULT",
           If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
             If(items.permanent_location LIKE "%Y%", "L_YA", 
               If(items.permanent_location LIKE "%CA%", "ADULT", 
                 If(items.permanent_location LIKE "%PROC%", "ADULT",
                   If(items.permanent_location IS NULL, "ADULT",
                     items.permanent_location
                   )
                 )
               )
             )
           )
         )
       )
     )
   ) icounts ON icounts.homebranch =
      branchess.branchcode AND
      icounts.permanent_location = branchess.authorised_value LEFT JOIN
  (SELECT
     If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch, 
     If(statistics.location = "BALDADULT", "ADULT", 
       If(statistics.location = "LVPLADULT", "ADULT", 
         If(statistics.location = "PAOLAADULT", "ADULT", 
           If(statistics.location LIKE "%CHILD%", "CHILDRENS", 
             If(statistics.location LIKE "%Y%", "L_YA", 
               If(statistics.location LIKE "%CA%", "ADULT", 
                 If(statistics.location LIKE "%PROC%", "ADULT", 
                   If(statistics.location IS NULL, "ADULT", statistics.location
                   )
                 )
               )
             )
           )
         )
       )
     ) AS LOCATION,
     count(&ast;) AS COUNT
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     statistics.datetime BETWEEN (AddDate(Last_Day(SubDate(Now(), INTERVAL 13
     MONTH)), 1)) AND (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
   GROUP BY
     If(statistics.branch IS NULL, "NEKLS", statistics.branch),
     If(statistics.location = "BALDADULT", "ADULT", 
       If(statistics.location =  "LVPLADULT", "ADULT", 
         If(statistics.location = "PAOLAADULT", "ADULT",  
           If(statistics.location LIKE "%CHILD%", "CHILDRENS", 
             If(statistics.location LIKE "%Y%", "L_YA", 
               If(statistics.location LIKE "%CA%", "ADULT", 
                 If(statistics.location LIKE "%PROC%", "ADULT", 
                   If(statistics.location IS  NULL, "ADULT", 
                     statistics.location
                   )
                 )
               )
             )
           )
         )
       )
     )
   ) statcounts ON
      statcounts.branch = branchess.branchcode AND
      statcounts.LOCATION = branchess.authorised_value
WHERE
  branchess.branchcode LIKE &lt;&gt;
GROUP BY
  branchess.branchcode,
  branchess.lib,
  icounts.Count_itemnumber,
  statcounts.COUNT
UNION
SELECT
  Concat('---') AS branchcode,
  Concat('---') AS LOCATION,
  Concat('---') AS CCODE,
  Concat('---') AS CURRENT_ITEM_COUNT,
  Concat('---') AS CKO_RENEW_COUNT,
  Concat('---') AS TURNOVER
UNION
SELECT
  branchesitypes.branchcode,
  branchesitypes.lib AS LOCATION,
  branchesitypes.lib1 AS CCODE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT,
  round((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
FROM
  (SELECT
     branches.branchcode,
     biblocs.category,
     biblocs.authorised_value,
     biblocs.lib,
     ccodes.authorised_value AS authorised_value1,
     ccodes.lib AS lib1
   FROM
     branches,
     (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'bibloc' AND
        authorised_values.authorised_value &lt;&gt; "YOUNGADULT") biblocs,
     (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'ccode') ccodes) branchesitypes LEFT JOIN
  (SELECT
     items.homebranch,
     If(items.permanent_location = "BALDADULT", "ADULT",
       If(items.permanent_location = "LVPLADULT", "ADULT",
         If(items.permanent_location = "PAOLAADULT", "ADULT",
           If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
             If(items.permanent_location LIKE "%Y%", "L_YA", 
               If(items.permanent_location LIKE "%CA%", "ADULT", 
                 If(items.permanent_location LIKE "%PROC%", "ADULT",
                   If(items.permanent_location IS NULL, "ADULT",
                     items.permanent_location
                   )
                 )
               )
             )
           )
         )
       )
     ) AS permanent_location,
     Coalesce(items.ccode, "XXX") AS ccode,
     Count(items.itemnumber) AS Count_itemnumber
   FROM
     items
   GROUP BY
     items.homebranch,
     If(items.permanent_location = "BALDADULT", "ADULT",
       If(items.permanent_location = "LVPLADULT", "ADULT",
         If(items.permanent_location = "PAOLAADULT", "ADULT",
           If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
             If(items.permanent_location LIKE "%Y%", "L_YA", 
               If(items.permanent_location  LIKE "%CA%", "ADULT", 
                 If(items.permanent_location LIKE "%PROC%", "ADULT",  
                   If(items.permanent_location IS NULL, "ADULT", 
                     items.permanent_location
                   )
                 )
               )
             )
           )
         )
       )
     ),
     Coalesce(items.ccode, "XXX")) icounts ON icounts.homebranch =
      branchesitypes.branchcode AND
      icounts.permanent_location = branchesitypes.authorised_value AND
      icounts.ccode = branchesitypes.authorised_value1 LEFT JOIN
  (SELECT
     If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
     If(statistics.location = "BALDADULT", "ADULT", 
       If(statistics.location = "LVPLADULT", "ADULT", 
         If(statistics.location = "PAOLAADULT", "ADULT", 
           If(statistics.location LIKE "%CHILD%", "CHILDRENS", 
             If(statistics.location LIKE "%Y%", "L_YA", 
               If(statistics.location LIKE "%CA%", "ADULT", 
                 If(statistics.location LIKE "%PROC%", "ADULT", 
                   If(statistics.location IS NULL, "ADULT", statistics.location
                   )
                 )
               )
             )
           )
         )
       )
     ) AS LOCATION,
     Coalesce(statistics.ccode, "XXX") AS ccode,
     count(&ast;) AS COUNT
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     statistics.datetime BETWEEN (AddDate(Last_Day(SubDate(Now(), INTERVAL 13
     MONTH)), 1)) AND (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
   GROUP BY
     If(statistics.branch IS NULL, "NEKLS", statistics.branch), 
     If(statistics.location = "BALDADULT", "ADULT", 
       If(statistics.location = "LVPLADULT", "ADULT", 
         If(statistics.location = "PAOLAADULT", "ADULT", 
           If(statistics.location LIKE "%CHILD%", "CHILDRENS", 
             If(statistics.location LIKE "%Y%", "L_YA", 
               If(statistics.location LIKE "%CA%", "ADULT", 
                 If(statistics.location LIKE "%PROC%", "ADULT", 
                   If(statistics.location IS NULL, "ADULT", 
                     statistics.location
                   )
                 )
               )
             )
           )
         )
       )
     ),
     statistics.ccode) statcounts ON
      statcounts.branch = branchesitypes.branchcode AND
      statcounts.LOCATION = branchesitypes.authorised_value AND
      statcounts.ccode = branchesitypes.authorised_value1
WHERE
  branchesitypes.branchcode LIKE &lt;&gt;
GROUP BY
  branchesitypes.branchcode,
  branchesitypes.lib,
  branchesitypes.lib1,
  icounts.Count_itemnumber,
  statcounts.COUNT
UNION
SELECT
  Concat('----') AS branchcode,
  Concat('----') AS LOCATION,
  Concat('----') AS CCODE,
  Concat('----') AS CURRENT_ITEM_COUNT,
  Concat('----') AS CKO_RENEW_COUNT,
  Concat('----') AS TURNOVER
UNION
  SELECT
  If(branchess.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED', 
    If(branchess.branchcode LIKE 'PH%', 'PH_COMBINED', 
      branchess.branchcode
    )
  ) AS branchcode,
  Concat("All locations") AS LOCATION,
  Concat("All collection codes") AS CCODE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT,
  ROUND((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
FROM
  (SELECT
      If(branches.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED',
        If(branches.branchcode LIKE 'PH%', 'PH_COMBINED', 
          branches.branchcode
        )
      ) AS branchcode
    FROM
      branches
    GROUP BY
      If(branches.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED',
        If(branches.branchcode LIKE 'PH%', 'PH_COMBINED', 
          branches.branchcode
        )
      )
    ) branchess LEFT JOIN
  (SELECT
      If(items.homebranch LIKE 'DONI%', 'DONIPHAN_COMBINED', 
        If(items.homebranch LIKE 'PH%', 'PH_COMBINED', 
          items.homebranch
        )
      ) AS homebranch,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      If(items.homebranch LIKE 'DONI%', 'DONIPHAN_COMBINED', 
        If(items.homebranch LIKE 'PH%', 'PH_COMBINED', 
          items.homebranch
        )
      )
  ) icounts ON icounts.homebranch = branchess.branchcode LEFT JOIN
  (SELECT
     If(statistics.branch LIKE 'DONI%', "DONIPHAN_COMBINED",
       If(statistics.branch LIKE 'PH%', 'PH_COMBINED', 
         statistics.branch
       )
     ) AS branch,
     count(&ast;) AS COUNT
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
       statistics.type = 'renew') AND
     statistics.datetime BETWEEN
       (AddDate(Last_Day(SubDate(Now(), INTERVAL 13 MONTH)), 1)) AND 
       (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
   GROUP BY
     If(statistics.branch LIKE 'DONI%', "DONIPHAN_COMBINED",
       If(statistics.branch LIKE 'PH%', 'PH_COMBINED', statistics.branch
       )
     )
  ) statcounts ON statcounts.branch = branchess.branchcode
WHERE
  If(branchess.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED',
    If(branchess.branchcode LIKE 'PH%', 'PH_COMBINED', 
      branchess.branchcode
    )
  ) LIKE &lt;&gt;
GROUP BY
  If(branchess.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED',
    If(branchess.branchcode LIKE 'PH%', 'PH_COMBINED', 
      branchess.branchcode
    )
  ),
  icounts.Count_itemnumber,
  statcounts.COUNT
UNION
SELECT
  Concat('-----') AS branchcode,
  Concat('-----') AS LOCATION,
  Concat('-----') AS CCODE,
  Concat('-----') AS CURRENT_ITEM_COUNT,
  Concat('-----') AS CKO_RENEW_COUNT,
  Concat('-----') AS TURNOVER
UNION
SELECT
  If(branchess.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED',
    If(branchess.branchcode LIKE 'PH%', 'PH_COMBINED', 
      branchess.branchcode
    )
  ) AS branchcode,
  branchess.lib AS LOCATION,
  Concat("All collection codes") AS CCODE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT,
  ROUND((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
FROM
  (SELECT
     If(branches.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED', 
       If(branches.branchcode LIKE 'PH%', 'PH_COMBINED', 
         branches.branchcode
       )
     ) AS branchcode,
     biblocs.authorised_value,
     biblocs.lib
   FROM
     branches,
     (SELECT
       authorised_values.category,
       authorised_values.authorised_value,
       authorised_values.lib
     FROM
       authorised_values
     WHERE
       authorised_values.category = 'bibloc' AND
       authorised_values.authorised_value &lt;&gt; "YOUNGADULT"
     ) biblocs
  ) branchess LEFT JOIN
  (SELECT
     If(items.homebranch LIKE 'DONI%', 'DONIPHAN_COMBINED', If(items.homebranch LIKE 'PH%', 'PH_COMBINED', items.homebranch)) AS homebranch,
       If(items.permanent_location = "BALDADULT", "ADULT", 
         If(items.permanent_location = "LVPLADULT", "ADULT", 
           If(items.permanent_location = "PAOLAADULT", "ADULT", 
             If(items.permanent_location LIKE "%CHILD%", "CHILDRENS", 
               If(items.permanent_location LIKE "%Y%", "L_YA", 
                 If(items.permanent_location LIKE "%CA%", "ADULT", 
                   If(items.permanent_location LIKE "%PROC%", "ADULT", 
                     If(items.permanent_location IS NULL, "ADULT", 
                       items.permanent_location
                     )
                   )
                 )
               )
             )
           )
         )
       ) AS permanent_location,
     Count(items.itemnumber) AS Count_itemnumber
   FROM
     items
   GROUP BY
     If(items.homebranch LIKE 'DONI%', 'DONIPHAN_COMBINED', 
       If(items.homebranch LIKE 'PH%', 'PH_COMBINED', 
         items.homebranch
       )
     ),
     If(items.permanent_location = "BALDADULT", "ADULT", 
       If(items.permanent_location = "LVPLADULT", "ADULT", 
         If(items.permanent_location = "PAOLAADULT", "ADULT", 
           If(items.permanent_location LIKE "%CHILD%", "CHILDRENS", 
             If(items.permanent_location LIKE "%Y%", "L_YA", 
               If(items.permanent_location LIKE "%CA%", "ADULT", 
                 If(items.permanent_location LIKE "%PROC%", "ADULT", 
                   If(items.permanent_location IS NULL, "ADULT", 
                     items.permanent_location
                   )
                 )
               )
             )
           )
         )
       )
     )
  ) icounts ON icounts.homebranch = branchess.branchcode AND
      icounts.permanent_location = branchess.authorised_value LEFT JOIN
  (SELECT
    If(statistics.branch LIKE 'DONI%', "DONIPHAN_COMBINED",
      If(statistics.branch LIKE 'PH%', 'PH_COMBINED', 
        statistics.branch
      )
    ) AS branch, 
    If(statistics.location = "BALDADULT", "ADULT", 
      If(statistics.location = "LVPLADULT", "ADULT", 
        If(statistics.location = "PAOLAADULT", "ADULT", 
          If(statistics.location LIKE "%CHILD%", "CHILDRENS", 
            If(statistics.location LIKE "%Y%", "L_YA", 
              If(statistics.location LIKE "%CA%", "ADULT", 
                If(statistics.location LIKE "%PROC%", "ADULT", 
                  If(statistics.location IS NULL, "ADULT", statistics.location
                  )
                )
              )
            )
          )
        )
      )
    ) AS LOCATION,
    count(&ast;) AS COUNT
  FROM
    statistics
  WHERE
    (statistics.type = 'issue' OR
      statistics.type = 'renew') AND
    statistics.datetime BETWEEN
      (AddDate(Last_Day(SubDate(Now(), INTERVAL 13 MONTH)), 1)) AND 
      (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
  GROUP BY
    If(statistics.branch LIKE 'DONI%', "DONIPHAN_COMBINED",
      If(statistics.branch LIKE 'PH%', 'PH_COMBINED', 
        statistics.branch
      )
    ), 
    If(statistics.location = "BALDADULT", "ADULT", 
      If(statistics.location = "LVPLADULT", "ADULT", 
        If(statistics.location = "PAOLAADULT", "ADULT", 
          If(statistics.location LIKE "%CHILD%", "CHILDRENS", 
            If(statistics.location LIKE "%Y%", "L_YA", 
              If(statistics.location LIKE "%CA%", "ADULT", 
                If(statistics.location LIKE "%PROC%", "ADULT", 
                  If(statistics.location IS  NULL, "ADULT", 
                    statistics.location
                  )
                )
              )
            )
          )
        )
      )
    )
  ) statcounts ON
    statcounts.branch = branchess.branchcode AND
    statcounts.LOCATION = branchess.authorised_value
WHERE
  If(branchess.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED',
    If(branchess.branchcode LIKE 'PH%', 'PH_COMBINED', 
      branchess.branchcode
    )
  ) LIKE &lt;&gt;
GROUP BY
  If(branchess.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED',
    If(branchess.branchcode LIKE 'PH%', 'PH_COMBINED', 
      branchess.branchcode
    )
  ),
  branchess.lib,
  icounts.Count_itemnumber,
  statcounts.COUNT
UNION 
SELECT
  Concat('------') AS branchcode,
  Concat('------') AS LOCATION,
  Concat('------') AS CCODE,
  Concat('------') AS CURRENT_ITEM_COUNT,
  Concat('------') AS CKO_RENEW_COUNT,
  Concat('------') AS TURNOVER
UNION 
SELECT
  branchesitypes.branchcode,
  branchesitypes.lib AS LOCATION,
  branchesitypes.lib1 AS CCODE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT,
  round((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
FROM
  (SELECT
      If(branches.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED',
        If(branches.branchcode LIKE 'PH%', 'PH_COMBINED', 
          branches.branchcode)) AS branchcode,
      biblocs.category,
      biblocs.authorised_value,
      biblocs.lib,
      ccodes.authorised_value AS authorised_value1,
      ccodes.lib AS lib1
    FROM
      branches,
      (SELECT
          authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib
        FROM
          authorised_values
        WHERE
          authorised_values.category = 'bibloc' AND
          authorised_values.authorised_value &lt;&gt; "YOUNGADULT") biblocs,
      (SELECT
          authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib
        FROM
          authorised_values
        WHERE
          authorised_values.category = 'ccode') ccodes) branchesitypes LEFT JOIN
  (SELECT
      If(items.homebranch LIKE 'DONI%', 'DONIPHAN_COMBINED', If(items.homebranch
      LIKE 'PH%', 'PH_COMBINED', items.homebranch)) AS homebranch,
      If(items.permanent_location = "BALDADULT", "ADULT",
        If(items.permanent_location = "LVPLADULT", "ADULT",
          If(items.permanent_location = "PAOLAADULT", "ADULT",
            If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
              If(items.permanent_location LIKE "%Y%", "L_YA",
                If(items.permanent_location LIKE "%CA%", "ADULT",
                  If(items.permanent_location LIKE "%PROC%", "ADULT",
                    If(items.permanent_location IS NULL, "ADULT",
                      items.permanent_location
                    )
                  )
                )
              )
            )
          )
        )
      ) AS permanent_location,
      Coalesce(items.ccode, "XXX") AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      If(items.homebranch LIKE 'DONI%', 'DONIPHAN_COMBINED', 
        If(items.homebranch LIKE 'PH%', 'PH_COMBINED', 
          items.homebranch)),
      If(items.permanent_location = "BALDADULT", "ADULT",
        If(items.permanent_location = "LVPLADULT", "ADULT",
          If(items.permanent_location = "PAOLAADULT", "ADULT",
            If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
              If(items.permanent_location LIKE "%Y%", "L_YA",
                If(items.permanent_location LIKE "%CA%", "ADULT",
                  If(items.permanent_location LIKE "%PROC%", "ADULT",
                    If(items.permanent_location IS NULL, "ADULT",
                      items.permanent_location
                    )
                  )
                )
              )
            )
          )
        )
      ),
      Coalesce(items.ccode, "XXX")) icounts ON icounts.homebranch =
      branchesitypes.branchcode AND
      icounts.permanent_location = branchesitypes.authorised_value AND
      icounts.ccode = branchesitypes.authorised_value1 LEFT JOIN
  (SELECT
      If(statistics.branch LIKE 'DONI%', 'DONIPHAN_COMBINED',
        If(statistics.branch LIKE 'PH%', 'PH_COMBINED', 
          statistics.branch)) AS
      branch,
      If(statistics.location = "BALDADULT", "ADULT", 
        If(statistics.location = "LVPLADULT", "ADULT", 
          If(statistics.location = "PAOLAADULT", "ADULT",
            If(statistics.location LIKE "%CHILD%", "CHILDRENS", 
              If(statistics.location LIKE "%Y%", "L_YA", 
                If(statistics.location LIKE "%CA%", "ADULT",
                  If(statistics.location LIKE "%PROC%", "ADULT", 
                    If(statistics.location IS NULL, "ADULT", 
                      statistics.location
                    )
                  )
                )
              )
            )
          )
        )
      ) AS LOCATION,
      Coalesce(statistics.ccode, "XXX") AS ccode,
      count(&ast;) AS COUNT
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      statistics.datetime BETWEEN 
        (AddDate(Last_Day(SubDate(Now(), INTERVAL 13 MONTH)), 1)) AND 
        (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
    GROUP BY
      If(statistics.branch LIKE 'DONI%', 'DONIPHAN_COMBINED',
        If(statistics.branch LIKE 'PH%', 'PH_COMBINED', 
          statistics.branch)),
      If(statistics.location = "BALDADULT", "ADULT", 
        If(statistics.location = "LVPLADULT", "ADULT", 
          If(statistics.location = "PAOLAADULT", "ADULT", 
            If(statistics.location LIKE "%CHILD%", "CHILDRENS", 
              If(statistics.location LIKE "%Y%", "L_YA", 
                If(statistics.location LIKE "%CA%", "ADULT", 
                  If(statistics.location LIKE "%PROC%", "ADULT", 
                    If(statistics.location IS NULL, "ADULT", 
                      statistics.location
                    )
                  )
                )
              )
            )
          )
        )
      ),
      Coalesce(statistics.ccode, "XXX")) statcounts ON 
      statcounts.branch = branchesitypes.branchcode AND
      statcounts.LOCATION = branchesitypes.authorised_value AND
      statcounts.ccode = branchesitypes.authorised_value1
WHERE
  branchesitypes.branchcode LIKE &lt;&gt;
GROUP BY
  branchesitypes.branchcode,
  branchesitypes.lib,
  branchesitypes.lib1,
  icounts.Count_itemnumber,
  statcounts.COUNT

























