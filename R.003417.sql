/*
R.003417

----------

Name: GHW ADMINREPORT - replace 3333
Created by: George Williams

----------

Group: -
     -

Created on: 2021-02-03 11:36:54
Modified on: 2021-02-03 14:04:18
Date last run: 2021-02-03 14:03:51

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws("&#160;&#160;&#160;&#160;&#160;", 
    clubs.name,
    branches.branchname, 
    club_templates.name
  ) AS CLUB_NAME,
  Concat_WS("",
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
    'Link to club roster for club members'
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
  clubs.branchcode LIKE &lt;&gt;
GROUP BY
  liaisons.LIAISON,
  leaders.LEADER,
  frequencys.FREQUENCY,
  urls.URL,
  clubs.id
ORDER BY
  branches.branchname,
  clubs.name

























