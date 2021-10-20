/*
R.003490

----------

Name: GHW - List of shelving location values
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-04-05 22:01:33
Modified on: 2021-04-05 22:02:14
Date last run: 2021-04-08 14:31:41

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  authorised_values.category,
  authorised_values.lib AS DESCRIPTION_STAFF,
  authorised_values.lib_opac AS DESCRIPTION_OPAC,
  authorised_values.authorised_value AS CODE,
  Group_Concat(authorised_values_branches.branchcode) AS LIMITED_BY_BRANCH
FROM
  authorised_values LEFT JOIN
  authorised_values_branches ON authorised_values_branches.av_id =
      authorised_values.id
WHERE
  authorised_values.category = 'LOC'
GROUP BY
  authorised_values.id
ORDER BY
  DESCRIPTION_STAFF

























