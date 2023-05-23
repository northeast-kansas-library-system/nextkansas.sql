/*
R.003050

----------

Name: GHW - GitHub SQL report 002
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-02-26 13:53:16
Modified on: 2018-09-06 16:51:56
Date last run: 2023-03-08 14:41:01

----------

Public: 0
Expiry: 300

----------

Report for uploading SQL to GitHub - part 2

----------
*/



SELECT
  Concat(
    LPad(saved_sql.id, 5, 0),
    "<br /><br />",
    Coalesce(saved_sql.report_name, "-"),
    "<br /><br />",
    Concat(Coalesce(groups.lib, "-"),
    "<br />",
    Coalesce(subgroups.lib, "-")),
    "<br /><br />",
    Concat("Created by:<br />", If(borrowers.borrowernumber IS NULL, "-", Concat(borrowers.firstname, " ", borrowers.surname)))
  ) AS NAME,
  Coalesce(saved_sql.notes, "-") AS NOTES
FROM
  saved_sql
  LEFT JOIN borrowers ON saved_sql.borrowernumber = borrowers.borrowernumber
  LEFT JOIN (SELECT
        authorised_values.id,
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.imageurl,
        authorised_values.lib_opac
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'REPORT_GROUP') groups ON saved_sql.report_group = groups.authorised_value
  LEFT JOIN (SELECT
        authorised_values.id,
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.imageurl,
        authorised_values.lib_opac
      FROM
        authorised_values) subgroups ON saved_sql.report_subgroup = subgroups.authorised_value
GROUP BY
  saved_sql.id
ORDER BY
  saved_sql.id
LIMIT 10000

























