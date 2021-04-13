/*
R.003346

----------

Name: GHW - Sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-14 15:14:53
Modified on: 2021-02-20 22:57:29
Date last run: 2021-02-12 02:22:03

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  authorised_values.id,
  authorised_values.category,
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.imageurl,
  authorised_values.lib_opac AS "ALTER DATABASE"
FROM
  authorised_values
WHERE
  authorised_values.category = 'CCODE'



