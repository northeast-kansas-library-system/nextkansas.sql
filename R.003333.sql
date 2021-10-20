/*
R.003333

----------

Name: GHW - CLUBS - List of all clubs
Created by: George H Williams

----------

Group: Clubs
     -

Created on: 2020-06-15 16:10:09
Modified on: 2021-02-03 15:13:25
Date last run: 2021-02-03 15:15:50

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates a list of all clubs</p>
<ul><li>List shows clubs that are current at the time you run the report</li>
<li>at the library you specify</li>
<li>grouped by club id number</li>
<li>sorted by club home library, club name, and club id number</li>
<li>contains links to report 3335 - which generates a list of club members that can be shared with other club members</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Updated on 2020.02.03</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3333&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">clubs</p>
</div>

----------
*/



SELECT
  Concat_Ws("<br />&#160;&#160;&#160;&#160;&#160;", 
    clubs.name,
    branches.branchname, 
    club_templates.name,
    Concat('Club ID number: ', clubs.id)
  ) AS CLUB_NAME,
  Concat_WS("<br />",
    liaisons.LIAISON,
    leaders.LEADER,
    frequencys.FREQUENCY,
    urls.URL,
    Concat(
      "Number of members: ", 
      counts.Count_borrowernumber
    )
  ) AS CLUB_INFO,
  CONCAT(
    '<a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3335&phase=Run+this+report&param_name=Enter+club+ID+number&sql_params=', 
    clubs.id, 
    '" target="_blank">Link to club roster for club members</a>'
  ) AS LINK_TO_ROSTER
FROM
  clubs JOIN
  club_templates ON clubs.club_template_id = club_templates.id  JOIN
  branches ON clubs.branchcode = branches.branchcode LEFT JOIN
  (SELECT
     club_fields.club_id,
     Concat_Ws(": ", 
       club_template_fields.name, 
       Coalesce(club_fields.value, "-")
     ) AS LIAISON,
     club_fields.club_template_field_id
   FROM
     club_fields  JOIN
     club_template_fields ON club_fields.club_template_field_id =
         club_template_fields.id
   WHERE
     (club_fields.club_template_field_id = 1 OR
         club_fields.club_template_field_id = 5)
   ORDER BY
     club_fields.club_id) liaisons ON liaisons.club_id = clubs.id LEFT JOIN
  (SELECT
     club_fields.club_id,
     Concat_Ws(": ", 
       club_template_fields.name, 
       Coalesce(club_fields.value, "-")
     ) AS LEADER,
     club_fields.club_template_field_id
   FROM
     club_fields JOIN
     club_template_fields ON club_fields.club_template_field_id =
         club_template_fields.id
   WHERE
     (club_fields.club_template_field_id = 2 OR
         club_fields.club_template_field_id = 6)
   ORDER BY
     club_fields.club_id) leaders ON leaders.club_id = clubs.id LEFT JOIN
  (SELECT
     club_fields.club_id,
     Concat_Ws(": ", 
       club_template_fields.name, 
       Coalesce(club_fields.value, "-")
     ) AS FREQUENCY,
     club_fields.club_template_field_id
   FROM
     club_fields JOIN
     club_template_fields ON club_fields.club_template_field_id =
         club_template_fields.id
   WHERE
     (club_fields.club_template_field_id = 3 OR
         club_fields.club_template_field_id = 7)
   ORDER BY
     club_fields.club_id) frequencys ON frequencys.club_id = clubs.id LEFT JOIN
  (SELECT
     club_fields.club_id,
     Concat_Ws(": ", 
       club_template_fields.name, 
       Coalesce(club_fields.value, "-")
     ) AS URL,
     club_fields.club_template_field_id
   FROM
     club_fields JOIN
     club_template_fields ON club_fields.club_template_field_id =
         club_template_fields.id
   WHERE
     (club_fields.club_template_field_id = 4 OR
         club_fields.club_template_field_id = 8)
   ORDER BY
     club_fields.club_id) urls ON urls.club_id = clubs.id LEFT JOIN
  (SELECT
     club_enrollments.club_id,
     Count(DISTINCT club_enrollments.borrowernumber) AS Count_borrowernumber
   FROM
     club_enrollments
   GROUP BY
     club_enrollments.club_id) counts ON counts.club_id = clubs.id
WHERE
  clubs.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  liaisons.LIAISON,
  leaders.LEADER,
  frequencys.FREQUENCY,
  urls.URL,
  clubs.id
ORDER BY
  branches.branchname,
  clubs.name

























