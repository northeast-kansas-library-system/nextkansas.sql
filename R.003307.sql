/*
R.003307

----------

Name: GHW - Authorised Values Synchronization - Item types
Created by: George Williams

----------

Group: -
     -

Created on: 2020-01-28 13:36:58
Modified on: 2025-11-24 14:31:43
Date last run: 2025-11-24 14:33:52

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  itemtypes_av.itemtype,
  itemtypes_av.description,
  itemtypes.description AS description1,
  authorized_values.lib,
  If(
    itemtypes.description IS NULL, 
    'AV only', 
    If(
      authorized_values.lib IS NULL, 
      'ITYPE only', 
      ''
    )
  ) AS Status
FROM
  (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
    GROUP BY
      itemtypes.itemtype,
      itemtypes.description
    UNION
    SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LITYPES'
    GROUP BY
      authorised_values.authorised_value,
      authorised_values.lib
  ) itemtypes_av 
  LEFT JOIN itemtypes 
    ON itemtypes.itemtype = itemtypes_av.itemtype 
  LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LITYPES'
    GROUP BY
      authorised_values.authorised_value,
      authorised_values.lib
  ) authorized_values 
    ON authorized_values.authorised_value = itemtypes_av.itemtype
GROUP BY
  itemtypes_av.itemtype,
  itemtypes_av.description,
  itemtypes.description,
  authorized_values.lib
ORDER BY
  itemtypes_av.description

























