/*
R.003912

----------

Name: GHW - List of lost statuses
Created by: George Williams

----------

Group: -
     -

Created on: 2025-08-28 10:58:57
Modified on: 2025-08-28 10:58:57
Date last run: 2025-08-29 10:46:02

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  authorised_values.category,
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac
FROM
  authorised_values
WHERE
  authorised_values.category = 'LOST'
ORDER BY
  authorised_values.lib

























