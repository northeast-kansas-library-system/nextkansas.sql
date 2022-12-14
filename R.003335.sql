/*
R.003335

----------

Name: GHW - CLUB Membership roster for club use
Created by: George H Williams

----------

Group: Clubs
     -

Created on: 2020-06-15 17:41:11
Modified on: 2021-02-03 16:35:38
Date last run: 2022-12-01 12:40:41

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Lists the members of a club in a format that can be shared with other members of the same club</p>
<ul><li>Shows current members of the club that you specify</li>
<li>grouped by club id number and borrowernumber</li>
<li>sorted by club enrollment number (order in which the members joined)</li>
<li>links</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3335&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">clubs</p>
</div>

----------
*/



SELECT
  clubs.name AS CLUB_NAME,
  Concat_Ws(
   '<br />', 
    If(
      name.value = 1, 
      Concat(
        borrowers.surname, 
        ', ', 
        borrowers.firstname, 
        If(
          borrowers.othernames = '', 
          '', 
          Concat(' (', borrowers.othernames, ')')
        )
      ), 
      '<u>Patron does not want their name shared with other members</u><br />'
    ),
    If(
      email.value = 1, 
      borrowers.email, 
      '<u>Patron does not want their e-mail shared with other members</u><br />'
    ),
    If(
      phone.value = 1, 
      borrowers.phone, 
      '<u>Patron does not want their phone number shared with other members</u><br />'
    ), 
    Concat(
      'Joined on: ', 
      Month(club_enrollments.date_enrolled), 
      '/', 
      Day(club_enrollments.date_enrolled), 
      '/', 
      Year(club_enrollments.date_enrolled)
    )
  ) AS CLUB_ROSTER_FOR_CLUB_MEMBERS
FROM
  clubs JOIN
  club_enrollments ON club_enrollments.club_id = clubs.id JOIN
  (SELECT
      club_enrollment_fields.id,
      club_enrollment_fields.club_enrollment_id,
      club_enrollment_fields.club_template_enrollment_field_id,
      club_enrollment_fields.value,
      club_template_enrollment_fields.description
    FROM
      club_enrollment_fields JOIN
      club_template_enrollment_fields ON
          club_enrollment_fields.club_template_enrollment_field_id =
          club_template_enrollment_fields.id
    WHERE
      club_template_enrollment_fields.name LIKE "%Name%") name ON
      name.club_enrollment_id = club_enrollments.id JOIN
  (SELECT
      club_enrollment_fields.id,
      club_enrollment_fields.club_enrollment_id,
      club_enrollment_fields.club_template_enrollment_field_id,
      club_enrollment_fields.value,
      club_template_enrollment_fields.description
    FROM
      club_enrollment_fields JOIN
      club_template_enrollment_fields ON
          club_enrollment_fields.club_template_enrollment_field_id =
          club_template_enrollment_fields.id
    WHERE
      club_template_enrollment_fields.name LIKE "%mail%") email ON
      email.club_enrollment_id = club_enrollments.id JOIN
  (SELECT
      club_enrollment_fields.id,
      club_enrollment_fields.club_enrollment_id,
      club_enrollment_fields.club_template_enrollment_field_id,
      club_enrollment_fields.value,
      club_template_enrollment_fields.description
    FROM
      club_enrollment_fields JOIN
      club_template_enrollment_fields ON
          club_enrollment_fields.club_template_enrollment_field_id =
          club_template_enrollment_fields.id
    WHERE
      club_template_enrollment_fields.name LIKE "%phone%") phone ON
      phone.club_enrollment_id = club_enrollments.id JOIN
  borrowers ON club_enrollments.borrowernumber = borrowers.borrowernumber
WHERE
  clubs.id = <<Enter club ID number>>
GROUP BY
  clubs.id,
  borrowers.borrowernumber
ORDER BY
  club_enrollments.id

























