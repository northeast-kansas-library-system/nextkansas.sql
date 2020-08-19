/*
R.003333

----------

Name: GHW - CLUBS - List of all clubs
Created by: George H Williams

----------

Group: Clubs
     -

Created on: 2020-06-15 16:10:09
Modified on: 2020-06-17 11:27:42
Date last run: 2020-07-28 14:11:25

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchname,
  clubs.id AS CLUB_ID,
  Concat(clubs.name, "<br />", clubs.description) AS CLUB_NAME_DESC,
  Concat(
    "Type: ",
    club_info.type_of_club,
    "<br />",
    club_info.field1,
    ":  ",
    club_info.liaison,
    "<br />",
    club_info.field2,
    ":  ",
    club_info.leader,
    "<br />",
    club_info.field3,
    ":  ",
    club_info.frequency,
    "<br />",
    club_info.field4,
    ":  ",
    CONCAT('<a href="', club_info.url, '" target="_blank">', club_info.url, '</a>')
  ) AS CLUB_INFORMATION,
  CONCAT('<a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3335&phase=Run+this+report&param_name=Enter+club+ID+number&sql_params=', clubs.id, '" target="_blank">Link to club roster</a>') AS LINK_TO_ROSTER
FROM
  branches JOIN
  clubs ON clubs.branchcode = branches.branchcode JOIN
  (SELECT
      club_templates.id,
      club_templates.name AS type_of_club,
      liason.name AS field1,
      liason.value AS liaison,
      leader.name AS field2,
      leader.value AS leader,
      frequency.name AS field3,
      frequency.value AS frequency,
      url.name AS field4,
      url.value AS url
    FROM
      club_templates LEFT JOIN
      (SELECT
          club_template_fields.id,
          club_template_fields.club_template_id,
          club_template_fields.name,
          club_template_fields.description,
          club_template_fields.authorised_value_category,
          club_fields.value
        FROM
          club_template_fields JOIN
          club_fields ON club_fields.club_template_field_id =
              club_template_fields.id
        WHERE
          club_template_fields.name LIKE "%lia%") liason ON
          liason.club_template_id = club_templates.id LEFT JOIN
      (SELECT
          club_template_fields.id,
          club_template_fields.club_template_id,
          club_template_fields.name,
          club_template_fields.description,
          club_template_fields.authorised_value_category,
          club_fields.value
        FROM
          club_template_fields JOIN
          club_fields ON club_fields.club_template_field_id =
              club_template_fields.id
        WHERE
          club_template_fields.name LIKE "%leader%") leader ON
          leader.club_template_id = club_templates.id LEFT JOIN
      (SELECT
          club_template_fields.id,
          club_template_fields.club_template_id,
          club_template_fields.name,
          club_template_fields.description,
          club_template_fields.authorised_value_category,
          club_fields.value
        FROM
          club_template_fields JOIN
          club_fields ON club_fields.club_template_field_id =
              club_template_fields.id
        WHERE
          club_template_fields.name LIKE "%frequency%") frequency ON
          frequency.club_template_id = club_templates.id LEFT JOIN
      (SELECT
          club_template_fields.id,
          club_template_fields.club_template_id,
          club_template_fields.name,
          club_template_fields.description,
          club_template_fields.authorised_value_category,
          club_fields.value
        FROM
          club_template_fields JOIN
          club_fields ON club_fields.club_template_field_id =
              club_template_fields.id
        WHERE
          club_template_fields.name LIKE "%URL%") url ON url.club_template_id =
          club_templates.id) club_info ON club_info.id = clubs.club_template_id
WHERE
  branches.branchcode LIKE <<Choose your library|ZBRAN>>



