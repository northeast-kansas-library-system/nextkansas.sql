/*
R.003112

----------

Name: GHW - T
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-08-13 00:35:23
Modified on: 2018-08-13 21:59:55
Date last run: 2018-08-13 22:02:13

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat("<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", borrowers.borrowernumber,
  "' target='_blank'>Patron</a>") AS LINK_TO_PATRON,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  Concat_Ws("", If(borrowers.surname = "", "-", borrowers.surname), " / ", If(borrowers.firstname = "", "-",
  borrowers.firstname), If(borrowers.othernames = "", " ", Concat(" - (", borrowers.othernames, ")"))) AS NAME,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.email,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateofbirth,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  Coalesce(school_teacher.lib, "~") AS TEACHER_ATTRIBUTE
FROM
  borrowers
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute
      FROM
        borrower_attributes
        INNER JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'TEACHER' AND
        authorised_values.category = 'TEACHER'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute) school_teacher ON borrowers.borrowernumber = school_teacher.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose your library|LBRANCH>> AND
  borrowers.categorycode LIKE <<Choose a borrower category|LBORROWERCAT>> AND
  Coalesce(school_teacher.attribute, "~") LIKE <<Select teacher attribute|TEACHER>>
GROUP BY
  borrowers.email,
  borrowers.dateofbirth,
  borrowers.borrowernumber,
  borrowers.othernames
ORDER BY
  borrowers.surname,
  borrowers.firstname



