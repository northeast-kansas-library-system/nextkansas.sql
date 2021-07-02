/*
R.003047

----------

Name: GHW - GitHub SQL report 001
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-02-01 02:37:30
Modified on: 2019-08-27 15:53:54
Date last run: 2021-07-02 17:27:17

----------

Public: 0
Expiry: 300

----------

Report for uploading SQL to GitHub - part 1

----------
*/

SELECT
  Concat(If(Length(saved_sql.savedsql) > 32766, "X.", "R."), LPad(saved_sql.id, 6, 0)) AS FILE_NAME,
  Concat(
    Concat("/*", Char(13), Char(10), "R.", LPad(saved_sql.id, 6, 0)), Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), Char(13), Char(10), Char(13), Char(10),
    Concat("Name: ", Coalesce(saved_sql.report_name, "-")), Char(13), Char(10),
    Concat("Created by: ", If(Coalesce(borrowers.borrowernumber, 0) = 0, "-", Concat(borrowers.firstname, " ", borrowers.surname))), Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), Char(13), Char(10), Char(13), Char(10),
    Concat("Group: ", Coalesce(reportgroups.lib, "-")), Char(13), Char(10),
    Concat("     ", Coalesce(reportsubgroups.lib, "-")), Char(13), Char(10), Char(13), Char(10),
    Concat("Created on: ", Coalesce(saved_sql.date_created, "-")), Char(13), Char(10),
    Concat("Modified on: ", Coalesce(saved_sql.last_modified, "-")), Char(13), Char(10),
    Concat("Date last run: ", Coalesce(saved_sql.last_run, "-")), Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), Char(13), Char(10), Char(13), Char(10),
    Concat("Public: ", Coalesce(saved_sql.public, "-")), Char(13), Char(10),
    Concat("Expiry: ", Coalesce(saved_sql.cache_expiry, "-")), Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), Char(13), Char(10), Char(13), Char(10),
    Concat(Coalesce(saved_sql.notes, "-")), Char(13), Char(10), Char(13), Char(10),
    Concat("----------", Char(13), Char(10), "*/"), Char(13), Char(10), Char(13), Char(10),
    Concat(IF(Length(saved_sql.savedsql) > 32766, "Too large to process", saved_sql.savedsql)), Char(13), Char(10), Char(13), Char(10)
  ) AS CONTENTS
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
        authorised_values.category = 'REPORT_GROUP') reportgroups ON
    saved_sql.report_group = reportgroups.authorised_value
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
        authorised_values.category = 'REPORT_SUBGROUP') reportsubgroups ON saved_sql.report_subgroup =
    reportsubgroups.authorised_value
GROUP BY
  saved_sql.id
ORDER BY
  FILE_NAME



