/*
R.003940

----------

Name: GHW - Daily item count by collection code
Created by: George Williams

----------

Group: -
     -

Created on: 2026-01-19 09:55:55
Modified on: 2026-01-19 09:55:55
Date last run: 2026-01-28 22:00:03

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  ccodes.lib AS COLLECTION_CODE,
  ccodes.authorised_value AS CCODE,
  Coalesce(itemss.Count_itemnumber, 0) AS ITEM_COUNT,
  Date_Format(CurDate(), "%y-%m-%d") AS DATE
FROM
  (SELECT
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    UNION
    SELECT
      '-' AS lib,
      ' No collection code' AS authorised_value,
      'CCODE' AS category) ccodes LEFT JOIN
  (SELECT
      Coalesce(items.ccode, '-') AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      Coalesce(items.ccode, '-')) itemss ON
      itemss.ccode = ccodes.authorised_value
GROUP BY
  ccodes.lib,
  ccodes.authorised_value
ORDER BY
  COLLECTION_CODE
LIMIT 250

























