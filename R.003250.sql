/*
R.003250

----------

Name: GHW - Damage display
Created by: George Williams

----------

Group: -
     -

Created on: 2019-08-14 15:38:39
Modified on: 2023-02-26 12:18:09
Date last run: 2025-03-08 22:41:04

----------

Public: 0
Expiry: 1

----------

Required for new "Damaged item" pop-up on checkin page.

----------
*/



SELECT
  Concat(
    '"&gt;Damaged item messageItem ',
    items.barcode,
    ' marked with DAMAGED status of "',
    damageds.lib,
    '" on ',
    IF(items.damaged_on is null, 'unknown date', Date_Format(items.damaged_on, '%Y-%m-%d')),
    '.DAMAGED statuses must be removed manually - they are not removed by the checkin process.',
    'damaged'
  ) AS MESSAGE,
  If(items.damaged &gt; 0, 'block', 'none') AS DISPLAY,
  damageds.lib
FROM
  items
  JOIN (
    SELECT
      authorised_values.id,
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.imageurl,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damageds
    ON damageds.authorised_value = items.damaged
WHERE
  items.barcode = &lt;&gt;

























