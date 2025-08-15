/*
R.003888

----------

Name: GHW - Search for duplicated codes in LOC, CCODE, and ITYPES
Created by: George Williams

----------

Group: -
     -

Created on: 2025-06-05 14:40:50
Modified on: 2025-06-05 14:40:55
Date last run: 2025-06-05 14:40:58

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  allcodes.authorised_value AS ALLCODES,
  CONCAT_WS('', 
    CONCAT_WS(' // ', 
      loc.category, 
      ccode.category, 
      itemtypes.CODE
    ), 
    If(
      Coalesce(loc.COUNT, 0) + 
        Coalesce(ccode.COUNT, 0) + 
          Coalesce(itemtypes.COUNT, 0) &gt; 1, 
      "-- duplicated codes in these settings", 
      ""
    )
  )
  AS TYPE
FROM
  (
    SELECT
      authorised_values.authorised_value
    FROM
      authorised_values
    WHERE
      (authorised_values.category = 'loc' OR
        authorised_values.category = 'ccode')
    UNION
    SELECT
      itemtypes.itemtype
    FROM
      itemtypes
  ) allcodes 
  LEFT JOIN
  (
    SELECT
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category,
      count(*) AS COUNT
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc'
    GROUP BY
      authorised_values.authorised_value
  ) loc 
    ON loc.authorised_value = allcodes.authorised_value 
  LEFT JOIN
  (
    SELECT
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category,
      count(*) AS COUNT
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode'
    GROUP BY
      authorised_values.authorised_value
  ) ccode 
    ON ccode.authorised_value = allcodes.authorised_value 
  LEFT JOIN
  (
    SELECT
      itemtypes.itemtype,
      itemtypes.description,
      'ITYPE' AS CODE,
      count(*) AS COUNT
    FROM
      itemtypes
    GROUP BY
      itemtypes.itemtype
  ) itemtypes 
    ON itemtypes.itemtype = allcodes.authorised_value
GROUP BY
  allcodes.authorised_value
ORDER BY
  ALLCODES

























