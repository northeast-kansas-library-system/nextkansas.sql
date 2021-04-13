/*
R.003485

----------

Name: GHW - ITYPE test
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-18 11:15:17
Modified on: 2021-03-18 11:38:04
Date last run: 2021-04-11 17:10:49

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat("Today's date:") AS branchcode,
  CURRENT_DATE() AS LOCATION,
  Concat('Start date:') AS ITYPE,
  (AddDate(Last_Day(SubDate(Now(), INTERVAL 13 MONTH)),
  1)) AS CURRENT_ITEM_COUNT,
  Concat('End date:') AS CKO_RENEW_COUNT,
  ((AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)) - INTERVAL
  1 DAY) AS TURNOVER
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
  IF(branchess.branchcode LIKE 'DONI%', 'DONIPHAN_ALL', branchess.branchcode) as branchcode,
  Concat("All locations") AS LOCATION,
  Concat("All item types") AS ITYPE,
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
     If(statistics.branch LIKE 'DONI%', "DONIPHAN_ALL", statistics.branch) AS branch,
     count(*) AS COUNT
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     statistics.datetime BETWEEN (AddDate(Last_Day(SubDate(Now(), INTERVAL 13
     MONTH)), 1)) AND (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
   GROUP BY
     If(statistics.branch LIKE 'DONI%', "DONIPHAN_ALL", statistics.branch)) statcounts ON
      statcounts.branch = branchess.branchcode
WHERE
  branchess.branchcode LIKE 'DONI%'
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
  IF(branchess.branchcode LIKE 'DONI%', 'DONIPHAN_ALL', branchess.branchcode) as branchcode,
  branchess.lib AS LOCATION,
  Concat("All item types") AS ITYPE,
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
        authorised_values.authorised_value <> "YOUNGADULT") biblocs) branchess
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
   ) icounts 
     ON icounts.homebranch =
      branchess.branchcode AND
      icounts.permanent_location = branchess.authorised_value LEFT JOIN
  (SELECT
     If(statistics.branch LIKE 'DONI%', "DONIPHAN_ALL", statistics.branch) AS branch,
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
     statistics.datetime BETWEEN (AddDate(Last_Day(SubDate(Now(), INTERVAL 13
     MONTH)), 1)) AND (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
   GROUP BY
     If(statistics.branch LIKE 'DONI%', "DONIPHAN_ALL", statistics.branch),
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
   ) statcounts ON
      statcounts.branch = branchess.branchcode AND
      statcounts.LOCATION = branchess.authorised_value
WHERE
  branchess.branchcode LIKE 'DONI%'
GROUP BY
  IF(branchess.branchcode LIKE 'DONI%', 'DONIPHAN_ALL', branchess.branchcode),
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
  IF(branchess.branchcode LIKE 'DONI%', 'DONIPHAN_ALL', branchess.branchcode) as branchcode,
  branchesitypes.lib AS LOCATION,
  branchesitypes.description AS ITYPE,
  icounts.Count_itemnumber AS CURRENT_ITEM_COUNT,
  statcounts.COUNT AS CKO_RENEW_COUNT,
  round((statcounts.COUNT / icounts.Count_itemnumber), 2) AS TURNOVER
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
        authorised_values.authorised_value <> "YOUNGADULT") biblocs)
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
     items.itype) icounts ON icounts.homebranch = branchesitypes.branchcode AND
      icounts.permanent_location = branchesitypes.authorised_value AND
      icounts.itype = branchesitypes.itemtype LEFT JOIN
  (SELECT
     If(statistics.branch LIKE 'DONI%', "DONIPHAN_ALL", statistics.branch) AS branch,
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
     statistics.datetime BETWEEN (AddDate(Last_Day(SubDate(Now(), INTERVAL 13
     MONTH)), 1)) AND (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))
   GROUP BY
     If(statistics.branch LIKE 'DONI%', "DONIPHAN_ALL", statistics.branch),
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
     If(statistics.itemtype IS NULL, "PUNC", statistics.itemtype)) statcounts ON
      statcounts.branch = branchesitypes.branchcode AND
      statcounts.itemtype = branchesitypes.itemtype AND
      statcounts.LOCATION = branchesitypes.authorised_value
WHERE
  branchesitypes.branchcode LIKE 'DONI%'
GROUP BY
  IF(branchesitypes.branchcode LIKE 'DONI%', 'DONIPHAN_ALL', branchesitypes.branchcode),
  branchesitypes.lib,
  branchesitypes.description,
  icounts.Count_itemnumber,
  statcounts.COUNT



