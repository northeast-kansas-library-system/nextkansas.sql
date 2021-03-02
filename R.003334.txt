/*
R.003334

----------

Name: GHW - CLUB Membership roster for library use only
Created by: George H Williams

----------

Group: Clubs
     -

Created on: 2020-06-15 17:13:07
Modified on: 2021-02-03 15:11:14
Date last run: 2021-02-03 15:16:29

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  clubs.name AS CLUB_NAME,
  borrowers.cardnumber,
  Concat_Ws('<br />', 
    Concat(
      borrowers.surname, 
      ', ', 
      borrowers.firstname, 
      If(
        borrowers.othernames = '', 
        '', 
        Concat(' (', borrowers.othernames,')')
      )
    ), 
    If(name.value = 1, '', '<u>Patron does not want their name shared</u><br />'), 
    borrowers.email,
    If(email.value = 1, '', '<u>Patron does not want their e-mail shared</u><br />'), 
    borrowers.phone, 
    If(phone.value = 1, '', '<u>Patron does not want their phone number shared</u><br />'),
    Concat(
      'Joined on: ', 
      Month(club_enrollments.date_enrolled), 
      '/', 
      Day(club_enrollments.date_enrolled), 
      '/', 
      Year(club_enrollments.date_enrolled)
    )
  ) AS CLUB_ROSTER_FOR_LIBRARY_USE_ONLY
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
ORDER BY
  club_enrollments.id



