/*
R.003101

----------

Name: GHW - Report Names
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-07-02 21:00:53
Modified on: 2018-07-03 08:21:11
Date last run: 2019-12-26 12:22:19

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  rg.lib AS GGROUP,
  rsg.lib AS SUB_GROUP,
  Concat("---<br />### Number: ", saved_sql.id, "<br />## Name: ", saved_sql.report_name, '<br /><br />', Replace(saved_sql.notes, '\r\n', CONCAT(Char(13),Char(10)))) AS INFO
FROM
  saved_sql
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'report_group'
      GROUP BY
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib) rg ON saved_sql.report_group = rg.authorised_value
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'report_subgroup'
      GROUP BY
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib) rsg ON saved_sql.report_subgroup = rsg.authorised_value
GROUP BY
  rg.lib,
  rsg.lib,
  saved_sql.id
ORDER BY
  GGROUP,
  SUB_GROUP,
  saved_sql.id

























