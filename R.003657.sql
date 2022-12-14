/*
R.003657

----------

Name: GHW - Shelving Locations
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-03-23 17:01:09
Modified on: 2022-03-23 17:02:05
Date last run: 2022-12-03 09:44:53

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  authorised_values.authorised_value AS CODE,
  authorised_values.lib AS STAFF_DISPLAY,
  authorised_values.lib_opac OPAC_DISPLAY,
  If(
    GROUP_CONCAT(DISTINCT authorised_values_branches.branchcode ORDER BY authorised_values_branches.branchcode) = "", 
    "All libraries",
    GROUP_CONCAT(DISTINCT authorised_values_branches.branchcode ORDER BY authorised_values_branches.branchcode)
  ) AS LIBRARY_AVAILABILITY
FROM
  authorised_values LEFT JOIN
  authorised_values_branches ON authorised_values_branches.av_id =
      authorised_values.id
WHERE
  authorised_values.category = 'LOC'
GROUP BY
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac
ORDER BY
  authorised_values.lib,
  authorised_values.lib_opac

























