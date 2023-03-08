/*
R.003047

----------

Name: GHW - GitHub SQL report 001
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-02-01 02:37:30
Modified on: 2021-10-20 09:49:31
Date last run: 2023-03-08 14:37:21

----------

Public: 0
Expiry: 300

----------

Report for uploading SQL to GitHub - part 1

----------
*/



SELECT
  Concat(
    If(Length(saved_sql.savedsql) > 32766, "X.", "R."), LPad(saved_sql.id, 6, 0)
  ) AS FILE_NAME,
  Concat(
    Concat("/*", Char(13), Char(10), "R.", LPad(saved_sql.id, 6, 0)), 
    Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), 
    Char(13), Char(10), Char(13), Char(10),
    Concat("Name: ", Coalesce(saved_sql.report_name, "-")), 
    Char(13), Char(10),
    Concat(
      "Created by: ", 
      If(
        Coalesce(borrowers.borrowernumber, 0) = 0, 
        "-", 
        Concat(borrowers.firstname, " ", borrowers.surname)
      )
    ), 
    Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), 
    Char(13), Char(10), Char(13), Char(10),
    Concat("Group: ", Coalesce(reportgroups.lib, "-")), 
    Char(13), Char(10),
    Concat("     ", Coalesce(reportsubgroups.lib, "-")), 
    Char(13), Char(10), Char(13), Char(10),
    Concat("Created on: ", Coalesce(saved_sql.date_created, "-")), 
    Char(13), Char(10),
    Concat("Modified on: ", Coalesce(saved_sql.last_modified, "-")), 
    Char(13), Char(10),
    Concat("Date last run: ", Coalesce(saved_sql.last_run, "-")), 
    Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), 
    Char(13), Char(10), Char(13), Char(10),
    Concat("Public: ", Coalesce(saved_sql.public, "-")), 
    Char(13), Char(10),
    Concat("Expiry: ", Coalesce(saved_sql.cache_expiry, "-")), 
    Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), 
    Char(13), Char(10), Char(13), Char(10),
    Concat(Coalesce(saved_sql.notes, "-")), Char(13), 
    Char(10), Char(13), Char(10),
    Concat("----------", Char(13), Char(10), "*/"), 
    Char(13), Char(10), Char(13), Char(10)
  ) AS CONTENTS,
  SubString(saved_sql.savedsql FROM 1 FOR 30000 ) AS PART_ONE,
  If(Length(saved_sql.savedsql) > 30000, "||AAAAA||", "") AS SEP_ONE,
  SubString(saved_sql.savedsql FROM 30001 FOR 30000 ) AS PART_TWO,
  If(Length(saved_sql.savedsql) > 60000, "||AAAAA||", "") AS SEP_TWO,
  SubString(saved_sql.savedsql FROM 60001 FOR 30000 ) AS PART_THREE,
  If(Length(saved_sql.savedsql) > 90000, "||AAAAA||", "") AS SEP_THREE,
  SubString(saved_sql.savedsql FROM 90001 FOR 30000 ) AS PART_FOUR,
  If(Length(saved_sql.savedsql) > 120000, "||AAAAA||", "") AS SEP_FOUR,
  SubString(saved_sql.savedsql FROM 120001 FOR 30000 ) AS PART_FIVE
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

























