/*
R.003627

----------

Name: GHW - Checkouts and renewals by date range at a library
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-12-05 00:58:23
Modified on: 2021-12-05 02:24:33
Date last run: 2021-12-09 13:37:24

----------

Public: 0
Expiry: 300

----------

Work in progress

----------
*/



SELECT
  branches_dates.branchname,
  branches_dates.dates,
  Coalesce(stats.CKO_RENEW, 0) AS CKO_RENEW
FROM
  (SELECT
     branches.branchcode,
     branches.branchname,
     Date_Format(statistics.datetime, "%Y.%m.%d") AS dates
   FROM
     statistics,
     branches
   WHERE
     branches.branchcode LIKE <<Choose a library|ZBRAN>> AND
     statistics.datetime BETWEEN <<Between the beginning of the day on date 1 (no more than 2 years ago)|date>> AND (<<the end of the day on date 2|date>> + interval 1 day)
   GROUP BY
     branches.branchcode,
     branches.branchname,
     Date_Format(statistics.datetime, "%Y.%m.%d")
   ORDER BY
     dates) branches_dates LEFT JOIN
  (SELECT
     Coalesce(statistics.branch, "NEKLS") AS branch,
     Date_Format(statistics.datetime, "%Y.%m.%d") AS dates,
     Count(*) AS CKO_RENEW
   FROM
     statistics LEFT JOIN
     (SELECT
        items.itemnumber,
        If(items.permanent_location LIKE "%ADULT%", 
          "ADULT",
          If(items.permanent_location LIKE "%YA%", 
            "L_YA",
            If(items.permanent_location LIKE "%CHILD%", 
              "CHILDRENS",
              If(items.permanent_location = "CATALOGING", 
                "OTHER",
                If(items.permanent_location = "PROC", 
                  "OTHER",
                  If(items.permanent_location IS NULL, 
                    "OTHER",
                    If(items.permanent_location = "", 
                      "OTHER", 
                      items.permanent_location
                    )
                  )
                )
              )
            )
          )
        ) AS permanent_location,
        items.itype,
        items.ccode
      FROM
        items
      WHERE
        If(items.permanent_location LIKE "%ADULT%", 
          "ADULT",
          If(items.permanent_location LIKE "%YA%", 
            "L_YA",
            If(items.permanent_location LIKE "%CHILD%", 
              "CHILDRENS",
              If(items.permanent_location = "CATALOGING", 
                "OTHER",
                If(items.permanent_location = "PROC", 
                  "OTHER",
                  If(items.permanent_location IS NULL, 
                    "OTHER",
                    If(items.permanent_location = "", 
                      "OTHER", 
                      items.permanent_location
                    )
                  )
                )
              )
            )
          )
        ) LIKE <<Choose a shelving location|LLOC>>
      UNION
      SELECT
        deleteditems.itemnumber,
        If(deleteditems.permanent_location = "BALDADULT", 
          "ADULT",
          If(deleteditems.permanent_location = "LVPLADULT", 
            "ADULT",
            If(deleteditems.permanent_location = "PAOLAADULT", 
              "ADULT",
              If(deleteditems.permanent_location LIKE "%CHILD%", 
                "CHILDRENS",
                If(deleteditems.permanent_location = "YOUNGADULT", 
                  "L_YA",
                  If(deleteditems.permanent_location LIKE "%YA%", 
                    "L_YA",
                    If(deleteditems.permanent_location = "CATALOGING", 
                      "OTHER",
                      If(deleteditems.permanent_location = "PROC", 
                        "OTHER",
                        If(deleteditems.permanent_location LIKE "CART", 
                          "OTHER",
                          If(deleteditems.permanent_location IS NULL, 
                            "OTHER",
                            If(deleteditems.permanent_location LIKE "", 
                              "OTHER", 
                              deleteditems.permanent_location
                            )
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        ) AS permanent_location,
        deleteditems.itype,
        deleteditems.ccode
      FROM
        deleteditems
      WHERE 
        If(deleteditems.permanent_location = "BALDADULT", 
          "ADULT",
          If(deleteditems.permanent_location = "LVPLADULT", 
            "ADULT",
            If(deleteditems.permanent_location = "PAOLAADULT", 
              "ADULT",
              If(deleteditems.permanent_location LIKE "%CHILD%", 
                "CHILDRENS",
                If(deleteditems.permanent_location = "YOUNGADULT", 
                  "L_YA",
                  If(deleteditems.permanent_location LIKE "%YA%", 
                    "L_YA",
                    If(deleteditems.permanent_location = "CATALOGING", 
                      "OTHER",
                      If(deleteditems.permanent_location = "PROC", 
                        "OTHER",
                        If(deleteditems.permanent_location LIKE "CART", 
                          "OTHER",
                          If(deleteditems.permanent_location IS NULL, 
                            "OTHER",
                            If(deleteditems.permanent_location LIKE "", 
                              "OTHER", 
                              deleteditems.permanent_location
                            )
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        ) LIKE <<Choose a shelving location|LLOC>>
      ) itemss ON itemss.itemnumber = statistics.itemnumber
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     If(
       statistics.location = "CART", 
       Coalesce(itemss.permanent_location, "OTHER"), 
       Coalesce(statistics.location, "OTHER")
     ) LIKE <<Choose a shelving location|LLOC>> AND
     Coalesce(statistics.itemtype, "PUNC") LIKE <<Choose an item type|LITYPES>> AND
     Coalesce(statistics.ccode, "XXX") LIKE <<Choose a collection code|LCCODE>> AND
     Coalesce(statistics.branch, "NEKLS") LIKE <<Choose a library|ZBRAN>> AND
     statistics.datetime BETWEEN <<Between the beginning of the day on date 1 (no more than 2 years ago)|date>> AND (<<the end of the day on date 2|date>> + interval 1 day)
   GROUP BY
     Coalesce(statistics.branch, "NEKLS"),
     Date_Format(statistics.datetime, "%Y.%m.%d")) stats ON
      stats.dates = branches_dates.dates AND
      stats.branch = branches_dates.branchcode
GROUP BY
  branches_dates.branchname,
  branches_dates.dates
ORDER BY
  branches_dates.branchname,
  branches_dates.dates

























