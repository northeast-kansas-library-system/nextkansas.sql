/*
R.003581

----------

Name: LibraryIQ - Circulation rules (in use) (setup)
Created by: George H Williams

----------

Group: LibraryIQ
     Setup

Created on: 2021-10-11 14:07:34
Modified on: 2021-10-13 11:11:17
Date last run: 2021-10-13 11:22:09

----------

Public: 0
Expiry: 300

----------

#libraryiq #setup

----------
*/



SELECT
  Concat_Ws(' | ', locs.lib, itemtypes.description, ccodes.lib) AS `Collection code (permanent location | item type | collection code)`,
  Concat('') AS Description,
  circulation_ruless.rule_value1 AS `Default (all borrowers) loan period at Bonner Springs`,
  Concat('ALL') AS `Branch/Library ID or ALL`,
  CurDate() AS `Report Date`
FROM
  (SELECT
      If(items.permanent_location LIKE "%ADULT%", 
        "ADULT",
        If(items.permanent_location LIKE "%CHILD%", 
          "CHILDRENS",
          If(items.permanent_location LIKE "%YA%", 
            "L_YA",
            If(items.permanent_location LIKE "%CATALOGING%", 
              "ADULT",
              If(items.permanent_location LIKE "%CART%", 
                "ADULT",
                If(items.permanent_location LIKE "%PROC%", 
                  "ADULT", 
                  items.permanent_location
                )
              )
            )
          )
        )
      ) AS PERM,
      Coalesce(items.itype, "BOOK") AS itype,
      items.ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      If(items.permanent_location LIKE "%ADULT%", 
        "ADULT",
        If(items.permanent_location LIKE "%CHILD%", 
          "CHILDRENS",
          If(items.permanent_location LIKE "%YA%", 
            "L_YA",
            If(items.permanent_location LIKE "%CATALOGING%", 
              "ADULT",
              If(items.permanent_location LIKE "%CART%", 
                "ADULT",
                If(items.permanent_location LIKE "%PROC%", 
                  "ADULT", 
                  items.permanent_location
                )
              )
            )
          )
        )
      ),
      Coalesce(items.itype, "BOOK"),
      items.ccode
    ORDER BY
      PERM,
      itype,
      items.ccode) item_counts LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc') locs ON locs.authorised_value =
      item_counts.PERM LEFT JOIN
  itemtypes ON itemtypes.itemtype = item_counts.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      item_counts.ccode LEFT JOIN
  (SELECT
      ruless.itemtype,
      ruless.description,
      ruless.rule_value1
    FROM
      (SELECT
          itemtypes.description,
          Coalesce(all_specific_rules.rule_value, all_all_rules.rule_value) AS
          rule_value1,
          itemtypes.itemtype
        FROM
          (SELECT
              circulation_rules.branchcode,
              circulation_rules.categorycode,
              circulation_rules.itemtype,
              circulation_rules.rule_name,
              circulation_rules.rule_value
            FROM
              circulation_rules
            WHERE
              circulation_rules.branchcode = 'BONNERSPGS' AND
              circulation_rules.rule_name = 'issuelength' AND
              circulation_rules.categorycode IS NULL AND
              circulation_rules.itemtype IS NULL) all_all_rules,
          itemtypes LEFT JOIN
          (SELECT
              circulation_rules.branchcode,
              circulation_rules.categorycode,
              circulation_rules.itemtype,
              circulation_rules.rule_name,
              circulation_rules.rule_value
            FROM
              circulation_rules
            WHERE
              circulation_rules.branchcode = <<Choose your library|branches>> AND
              circulation_rules.rule_name = 'issuelength' AND
              circulation_rules.categorycode IS NULL AND
              circulation_rules.itemtype IS NOT NULL) all_specific_rules ON
              all_specific_rules.itemtype = itemtypes.itemtype
        ORDER BY
          itemtypes.description) ruless) circulation_ruless ON
      circulation_ruless.itemtype = itemtypes.itemtype
GROUP BY
  Concat_Ws(' | ', locs.lib, itemtypes.description, ccodes.lib),
  circulation_ruless.rule_value1
ORDER BY
  `Collection code (permanent location | item type | collection code)`

























