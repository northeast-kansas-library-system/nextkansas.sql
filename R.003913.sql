/*
R.003913

----------

Name: NH-list of claims returned statuses
Created by: Nikki Hansen

----------

Group: -
     -

Created on: 2025-08-29 10:37:46
Modified on: 2025-08-29 10:48:13
Date last run: 2025-08-29 10:43:48

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
  authorised_values.category = 'RETURN_CLAIM_RESOLUTION'
ORDER BY
  authorised_values.lib

























