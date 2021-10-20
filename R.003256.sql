/*
R.003256

----------

Name: GHW - School attributes
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-22 13:32:13
Modified on: 2021-08-15 22:20:53
Date last run: 2021-08-16 00:16:48

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    "<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", 
    borrowers.borrowernumber, 
    "' target='_blank'>Patron</a>"
  ) AS LINK_TO_PATRON,
  borrowers.cardnumber,
  Concat_Ws("", 
    If(
      borrowers.surname = "", 
      "-", 
      borrowers.surname
    ), 
    " / ", 
    If(
      borrowers.firstname = "", 
      "-", 
      borrowers.firstname
    ), 
    If(
      borrowers.othernames = "", 
      " ", 
      Concat(" - (", borrowers.othernames, ")")
    )
  ) AS NAME,
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
  Coalesce(grade.lib, "~") AS GRADE,
  Coalesce(teacher.lib, "~") AS TEACHER
FROM
  borrowers
  LEFT JOIN (
    SELECT
      borrower_attributes.borrowernumber,
      authorised_values.lib,
      borrower_attributes.attribute
    FROM
      borrower_attributes
      JOIN authorised_values
        ON borrower_attributes.attribute = authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'GRADE'
    GROUP BY
      borrower_attributes.borrowernumber,
      borrower_attributes.attribute
  ) grade
    ON borrowers.borrowernumber = grade.borrowernumber
  LEFT JOIN (
    SELECT
      borrower_attributes.borrowernumber,
      authorised_values.lib,
      borrower_attributes.attribute
    FROM
      borrower_attributes
      JOIN authorised_values
        ON borrower_attributes.attribute = authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'USD113_T'
    GROUP BY
      borrower_attributes.borrowernumber,
      borrower_attributes.attribute
  ) teacher
    ON teacher.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>> AND
  borrowers.categorycode LIKE <<Choose a borrower category|LBORROWERCAT>> AND
  Coalesce(grade.attribute, "~") LIKE '%' AND
  Coalesce(teacher.attribute, "~") LIKE '%'
GROUP BY
  Coalesce(grade.lib, "~"),
  borrowers.borrowernumber
ORDER BY
  borrowers.surname,
  borrowers.firstname

























