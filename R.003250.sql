/*
R.003250

----------

Name: GHW - Damage display
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-14 15:38:39
Modified on: 2021-01-12 23:47:22
Date last run: 2021-07-02 17:26:57

----------

Public: 0
Expiry: 1

----------

Required for new "Damaged item" pop-up on checkin page.

----------
*/

SELECT
  Concat(
    '"><h2>Damaged item message</h2><h3 id="damageditem" class="problem">Item ',
    items.barcode,
    ' marked with DAMAGED status of "',
    damageds.lib,
    '" on ',
    IF(items.damaged_on is null, 'unknown date', Date_Format(items.damaged_on, '%Y-%m-%d')),
    '.</h3><p>DAMAGED statuses must be removed manually - they are not removed by the checkin process.</p>'
  ) AS MESSAGE,
  If(items.damaged > 0, 'block', 'none') AS DISPLAY,
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
  items.barcode = <<Enter item barcode number>>



