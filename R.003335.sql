/*
R.003335

----------

Name: GHW - CLUB Membership roster for club use
Created by: George Williams

----------

Group: Clubs
     -

Created on: 2020-06-15 17:41:11
Modified on: 2024-01-17 12:04:49
Date last run: 2022-12-01 12:40:41

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Lists the members of a club in a format that can be shared with other members of the same club&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current members of the club that you specify&lt;/li&gt;
&lt;li&gt;grouped by club id number and borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by club enrollment number (order in which the members joined)&lt;/li&gt;
&lt;li&gt;links&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3335&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;clubs&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  clubs.name AS CLUB_NAME,
  Concat_Ws(
   '', 
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
      'Patron does not want their name shared with other members'
    ),
    If(
      email.value = 1, 
      borrowers.email, 
      'Patron does not want their e-mail shared with other members'
    ),
    If(
      phone.value = 1, 
      borrowers.phone, 
      'Patron does not want their phone number shared with other members'
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
  clubs.id = &lt;&gt;
GROUP BY
  clubs.id,
  borrowers.borrowernumber
ORDER BY
  club_enrollments.id

























