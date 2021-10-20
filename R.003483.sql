/*
R.003483

----------

Name: GHW- Turnover in the previous 12 months by location and item type
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-16 23:02:31
Modified on: 2021-03-25 01:36:00
Date last run: 2021-04-19 16:18:36

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Shows turnover rate by location and item type</p>
<ul><li>in the previous 12 months</li>
<li>at the library you specify</li>
<li>grouped by library, location, and item type</li>
<li>sorted by library, location, and item type with an "All locations" and "All item types" grouping at the top of the results</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Developed for "Collection development 2.0" workshop</p>
<p></p>
<p>Please note that these calculations include all items checked out at your library regardless of which library owned the item.  If, for example, your library doesn't own any items with a "Pamphlet" item type but one from another library was checked out at your library to fill a request, that item will be counted in these calculations.</p>
<p></p>
<p>"CURRENT_ITEM_COUNT" is based on an item's item type at the time the report was run.  "CKO_RENEW_COUNT" is based on an item's item type at the time it was checked out.  It an item's item type changes between the time it was checked out and the time this report is run, the results will be skewed.  This will be particularly true of items with the following temporary item types:</p>
<ul>
<li>Audiobook (new)</li>
<li>Book (new)</li>
<li>Book (no requests allowed)</li>
<li>BORROWED FROM ANOTHER LIBRARY</li>
<li>Magazine (new)</li>
<li>Video (Local requests only)</li>
<li>Video (New)</li>
<li>Video (No holds allowed)</li>
</ul>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3483&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">statistics, turnover, previous 12 months</p>
</div>

----------
*/



SELECT
  Concat("Today's date:") AS branchcode,
  CURRENT_DATE() AS LOCATION,
  Concat('Report start date:') AS ITYPE,
  (AddDate(Last_Day(SubDate(Now(), INTERVAL 13 MONTH)), 1)) AS CURRENT_ITEM_COUNT, 
  Concat('Report end date:') AS CKO_RENEW_COUNT,
  ((AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)) - INTERVAL 1 DAY) AS TURNOVER
UNION
SELECT
  Concat("-") AS branchcode,
  Concat("-") AS LOCATION,
  Concat("-") AS ITYPE,
  Concat("-") AS CURRENT_ITEM_COUNT,
  Concat("-") AS CKO_RENEW_COUNT,
  Concat("-") AS TURNOVER
UNION
SELECT
  branchess.branchcode,
  Concat("All locations") AS LOCATION,
  Concat("All item types") AS ITYPE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT, 
  ROUND((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
FROM
  (SELECT
     branches.branchcode
   FROM
     branches
   GROUP BY
     branches.branchcode
  ) branchess LEFT JOIN
  (SELECT
     items.homebranch,
     Count(items.itemnumber) AS Count_itemnumber
   FROM
     items
   GROUP BY
     items.homebranch
  ) icounts ON icounts.homebranch = branchess.branchcode
  LEFT JOIN
  (SELECT
     If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
     count(*) AS COUNT
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     statistics.datetime BETWEEN 
       (AddDate(Last_Day(SubDate(Now(), INTERVAL 13 MONTH)), 1)) AND 
       (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
   GROUP BY
     If(statistics.branch IS NULL, "NEKLS", statistics.branch)
  ) statcounts ON statcounts.branch = branchess.branchcode
WHERE
  branchess.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branchess.branchcode,
  icounts.Count_itemnumber,
  statcounts.COUNT
UNION
SELECT
  Concat('--') AS branchcode,
  Concat('--') AS LOCATION,
  Concat('--') AS ITYPE,
  Concat('--') AS CURRENT_ITEM_COUNT,
  Concat('--') AS CKO_RENEW_COUNT,
  Concat('--') AS TURNOVER
UNION
SELECT
  branchess.branchcode,
  branchess.lib AS LOCATION,
  Concat("All item types") AS ITYPE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT,
  ROUND((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
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
        authorised_values.authorised_value <> "YOUNGADULT"
     ) biblocs
  ) branchess
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
  ) icounts ON icounts.homebranch = branchess.branchcode AND
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
     count(*) AS COUNT
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     statistics.datetime BETWEEN 
       (AddDate(Last_Day(SubDate(Now(), INTERVAL 13 MONTH)), 1)) AND 
       (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
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
     )
  ) statcounts ON statcounts.branch = branchess.branchcode AND
      statcounts.LOCATION = branchess.authorised_value
WHERE
  branchess.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branchess.branchcode,
  branchess.lib,
  icounts.Count_itemnumber,
  statcounts.COUNT
UNION
SELECT
  Concat('---') AS branchcode,
  Concat('---') AS LOCATION,
  Concat('---') AS ITYPE,
  Concat('---') AS CURRENT_ITEM_COUNT,
  Concat('---') AS CKO_RENEW_COUNT,
  Concat('---') AS TURNOVER
UNION
SELECT
  branchesitypes.branchcode,
  branchesitypes.lib AS LOCATION,
  branchesitypes.description AS ITYPE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT,
  ROUND((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
FROM
  (SELECT
     branches.branchcode,
     itemtypes.itemtype,
     itemtypes.description,
     biblocs.category,
     biblocs.authorised_value,
     biblocs.lib
   FROM
     branches,
     itemtypes,
     (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'bibloc' AND
        authorised_values.authorised_value <> "YOUNGADULT"
     ) biblocs
  )
  branchesitypes LEFT JOIN
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
     items.itype,
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
     ),
     items.itype
  ) icounts ON icounts.homebranch = branchesitypes.branchcode AND
      icounts.permanent_location = branchesitypes.authorised_value AND
      icounts.itype = branchesitypes.itemtype LEFT JOIN
  (SELECT
     If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
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
     If(statistics.itemtype IS NULL, "PUNC", statistics.itemtype) AS itemtype,
     count(*) AS COUNT
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     statistics.datetime BETWEEN 
       (AddDate(Last_Day(SubDate(Now(), INTERVAL 13 MONTH)), 1)) AND 
       (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
   GROUP BY
     If(statistics.branch IS NULL, "NEKLS", statistics.branch),
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
     ),
     If(statistics.itemtype IS NULL, "PUNC", statistics.itemtype)
  ) statcounts ON
      statcounts.branch = branchesitypes.branchcode AND
      statcounts.itemtype = branchesitypes.itemtype AND
      statcounts.LOCATION = branchesitypes.authorised_value
WHERE
  branchesitypes.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branchesitypes.branchcode,
  branchesitypes.lib,
  branchesitypes.description,
  icounts.Count_itemnumber,
  statcounts.COUNT
UNION
SELECT
  Concat('----') AS branchcode,
  Concat('----') AS LOCATION,
  Concat('----') AS ITYPE,
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
  Concat("All item types") AS ITYPE,
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
     count(*) AS COUNT
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
  ) LIKE <<Choose your library|ZBRAN>>
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
  Concat('-----') AS ITYPE,
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
  Concat("All item types") AS ITYPE,
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
       authorised_values.authorised_value <> "YOUNGADULT"
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
    count(*) AS COUNT
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
  ) LIKE <<Choose your library|ZBRAN>>
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
  Concat('------') AS ITYPE,
  Concat('------') AS CURRENT_ITEM_COUNT,
  Concat('------') AS CKO_RENEW_COUNT,
  Concat('------') AS TURNOVER
UNION 
SELECT
  branchesitypes.branchcode,
  branchesitypes.lib AS LOCATION,
  branchesitypes.description AS ITYPE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT,
  ROUND((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
FROM
  (SELECT
    If(branches.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED',
      If(branches.branchcode LIKE 'PH%', 'PH_COMBINED', 
        branches.branchcode)) AS branchcode,
    itemtypes.itemtype,
    itemtypes.description,
    biblocs.category,
    biblocs.authorised_value,
    biblocs.lib
  FROM
    branches,
    itemtypes,
  (SELECT
    authorised_values.category,
    authorised_values.authorised_value,
    authorised_values.lib
  FROM
    authorised_values
  WHERE
    authorised_values.category = 'bibloc' AND
    authorised_values.authorised_value <> "YOUNGADULT") biblocs
  GROUP BY
    If(branches.branchcode LIKE 'DONI%', 'DONIPHAN_COMBINED',
      If(branches.branchcode LIKE 'PH%', 'PH_COMBINED', 
        branches.branchcode
      )
    ),
    itemtypes.itemtype,
    itemtypes.description,
    biblocs.category,
    biblocs.authorised_value,
    biblocs.lib
  ) branchesitypes LEFT JOIN
  (SELECT
    If(items.homebranch LIKE 'DONI%', 'DONIPHAN_COMBINED', 
      If(items.homebranch LIKE 'PH%', 'PH_COMBINED', 
        items.homebranch
      )
    ) AS homebranch,
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
    items.itype,
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
    ),
    items.itype
  ) icounts ON icounts.homebranch = branchesitypes.branchcode AND
    icounts.permanent_location = branchesitypes.authorised_value AND
    icounts.itype = branchesitypes.itemtype LEFT JOIN
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
    If(statistics.itemtype IS NULL, "PUNC", statistics.itemtype) AS itemtype,
    count(*) AS COUNT
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
    If(statistics.itemtype IS NULL, "PUNC", 
      statistics.itemtype
    )
  ) statcounts ON statcounts.branch = branchesitypes.branchcode AND
    statcounts.itemtype = branchesitypes.itemtype AND
    statcounts.LOCATION = branchesitypes.authorised_value
WHERE
  branchesitypes.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branchesitypes.branchcode,
  branchesitypes.lib,
  branchesitypes.description,
  icounts.Count_itemnumber,
  statcounts.COUNT

























