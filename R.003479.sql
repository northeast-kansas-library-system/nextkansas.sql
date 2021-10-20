/*
R.003479

----------

Name: GHW - Average by location and collection code
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-05 14:08:29
Modified on: 2021-03-05 17:16:03
Date last run: 2021-03-25 01:44:46

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches_locations.branchcode,
  branches_locations.LOCATION_DESCRIPTION,
  branches_locations.CCODE_DESCRIPTION,
  count_total.Count_itemnumber AS ITEMS_COUNT_TOTAL,
  count_with_pubyear.Count_itemnumber AS ITEMS_COUNT_W_PUBYEAR,
  floor(Avg(average_age.publicationyear)) AS Avg_publicationyear
FROM
  (SELECT
      branches.branchcode,
      locations.lib AS LOCATION_DESCRIPTION,
      locations.category AS LOCATION_CATEGORY,
      locations.authorised_value AS LOCATION_CODE,
      ccodes.lib AS CCODE_DESCRIPTION,
      ccodes.category AS CCODE_CATEGORY,
      ccodes.authorised_value AS CCODE_CODE
    FROM
      branches,
      authorised_values locations,
      authorised_values ccodes
    WHERE
      locations.category = 'bibloc' AND
      locations.authorised_value <> 'YOUNGADULT' AND
      branches.branchcode LIKE <<Choose your library|ZBRAN>> AND
      ccodes.authorised_value = <<Choose a collection code|CCODE>>) branches_locations LEFT JOIN
  (SELECT
      items.homebranch,
      Count(DISTINCT items.itemnumber) AS Count_itemnumber,
      If(items.permanent_location LIKE "%YA%", "L_YA",
        If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
          If(items.permanent_location LIKE "%ADULT%", "ADULT",
            If(items.permanent_location LIKE "%PROC%", "L_YA",
              If(items.permanent_location LIKE "%CART%", "L_YA",
                If(items.permanent_location LIKE "%CATALOGING%", "L_YA", items.permanent_location)
              )
            )
          )
        )) AS LOCATION,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      items
    WHERE
      items.homebranch LIKE <<Choose your library|ZBRAN>> AND
      If(items.permanent_location LIKE "%YA%", "L_YA",
        If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
          If(items.permanent_location LIKE "%ADULT%", "ADULT",
            If(items.permanent_location LIKE "%PROC%", "L_YA",
              If(items.permanent_location LIKE "%CART%", "L_YA",
                If(items.permanent_location LIKE "%CATALOGING%", "L_YA", items.permanent_location)
              )
            )
          )
        )
      ) LIKE <<Choose a shelving location|lbibloc>> AND
      Coalesce(items.ccode, "XXX") = <<Choose a collection code|CCODE>>
    GROUP BY
      items.homebranch,
      If(items.permanent_location LIKE "%YA%", "L_YA",
        If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
          If(items.permanent_location LIKE "%ADULT%", "ADULT",
            If(items.permanent_location LIKE "%PROC%", "L_YA",
              If(items.permanent_location LIKE "%CART%", "L_YA",
                If(items.permanent_location LIKE "%CATALOGING%", "L_YA", items.permanent_location)
              )
            )
          )
        )
      ),
      Coalesce(items.ccode, "XXX")) count_total ON count_total.homebranch =
      branches_locations.branchcode AND
      count_total.LOCATION = branches_locations.LOCATION_CODE AND
      count_total.ccode = branches_locations.CCODE_CODE LEFT JOIN
  (SELECT
      items.homebranch,
      Count(DISTINCT items.itemnumber) AS Count_itemnumber,
      If(items.permanent_location LIKE "%YA%", "L_YA",
        If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
          If(items.permanent_location LIKE "%ADULT%", "ADULT",
            If(items.permanent_location LIKE "%PROC%", "L_YA",
              If(items.permanent_location LIKE "%CART%", "L_YA",
                If(items.permanent_location LIKE "%CATALOGING%", "L_YA", items.permanent_location)
              )
            )
          )
        )
      ) AS LOCATION,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      biblioitems JOIN
      items ON items.biblioitemnumber = biblioitems.biblioitemnumber
    WHERE
      biblioitems.publicationyear < Year(Now()) AND
      biblioitems.publicationyear REGEXP '^[0-9]+$' AND
      items.homebranch LIKE <<Choose your library|ZBRAN>> AND
      If(items.permanent_location LIKE "%YA%", "L_YA",
        If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
          If(items.permanent_location LIKE "%ADULT%", "ADULT",
            If(items.permanent_location LIKE "%PROC%", "L_YA",
              If(items.permanent_location LIKE "%CART%", "L_YA",
                If(items.permanent_location LIKE "%CATALOGING%", "L_YA", items.permanent_location)
              )
            )
          )
        )
      ) LIKE <<Choose a shelving location|lbibloc>> AND
      Coalesce(items.ccode, "XXX") = <<Choose a collection code|CCODE>>
    GROUP BY
      items.homebranch,
      If(items.permanent_location LIKE "%YA%", "L_YA",
        If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
          If(items.permanent_location LIKE "%ADULT%", "ADULT",
            If(items.permanent_location LIKE "%PROC%", "L_YA",
              If(items.permanent_location LIKE "%CART%", "L_YA",
                If(items.permanent_location LIKE "%CATALOGING%", "L_YA", items.permanent_location)
              )
            )
          )
        )
      )
    ) count_with_pubyear ON
      count_with_pubyear.homebranch = branches_locations.branchcode AND
      count_with_pubyear.LOCATION = branches_locations.LOCATION_CODE AND
      count_with_pubyear.ccode = branches_locations.CCODE_CODE LEFT JOIN
  (SELECT
      items.homebranch,
      items.itemnumber,
      biblioitems.publicationyear,
      If(items.permanent_location LIKE "%YA%", "L_YA",
        If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
          If(items.permanent_location LIKE "%ADULT%", "ADULT",
            If(items.permanent_location LIKE "%PROC%", "L_YA",
              If(items.permanent_location LIKE "%CART%", "L_YA",
                If(items.permanent_location LIKE "%CATALOGING%", "L_YA", items.permanent_location)
              )
            )
          )
        )
      ) AS LOCATION,
      Coalesce(items.ccode, "XXX") AS ccode
    FROM
      biblioitems JOIN
      items ON items.biblioitemnumber = biblioitems.biblioitemnumber
    WHERE
      biblioitems.publicationyear < Year(Now()) AND
      biblioitems.publicationyear REGEXP '^[0-9]+$' AND
      items.homebranch LIKE <<Choose your library|ZBRAN>> AND
      If(items.permanent_location LIKE "%YA%", "L_YA",
        If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
          If(items.permanent_location LIKE "%ADULT%", "ADULT",
            If(items.permanent_location LIKE "%PROC%", "L_YA",
              If(items.permanent_location LIKE "%CART%", "L_YA",
                If(items.permanent_location LIKE "%CATALOGING%", "L_YA", items.permanent_location)
              )
            )
          )
        )
      ) LIKE <<Choose a shelving location|lbibloc>> AND
      Coalesce(items.ccode, "XXX") = <<Choose a collection code|CCODE>>
    GROUP BY
      items.homebranch,
      items.itemnumber,
      biblioitems.publicationyear,
      If(items.permanent_location LIKE "%YA%", "L_YA",
        If(items.permanent_location LIKE "%CHILD%", "CHILDRENS",
          If(items.permanent_location LIKE "%ADULT%", "ADULT",
            If(items.permanent_location LIKE "%PROC%", "L_YA",
              If(items.permanent_location LIKE "%CART%", "L_YA",
                If(items.permanent_location LIKE "%CATALOGING%", "L_YA", items.permanent_location)
              )
            )
          )
        )
      )
    ) average_age ON average_age.homebranch =
      branches_locations.branchcode AND
      average_age.LOCATION = branches_locations.LOCATION_CODE AND
      average_age.ccode = branches_locations.CCODE_CODE
WHERE
  branches_locations.branchcode LIKE <<Choose your library|ZBRAN>> AND
  branches_locations.LOCATION_CODE LIKE <<Choose a shelving location|lbibloc>> AND
  branches_locations.CCODE_CODE = <<Choose a collection code|CCODE>>
GROUP BY
  branches_locations.branchcode,
  branches_locations.LOCATION_DESCRIPTION,
  branches_locations.CCODE_DESCRIPTION,
  count_total.Count_itemnumber,
  count_with_pubyear.Count_itemnumber,
  branches_locations.CCODE_CODE

























