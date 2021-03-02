/*
R.003358

----------

Name: GHW - Sandbox - Attribute testing
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-10-14 00:26:15
Modified on: 2020-10-14 01:25:23
Date last run: 2020-10-14 01:56:34

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.othernames,
  borrowers.streetnumber,
  borrowers.streettype,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  borrowers.date_renewed,
  borrowers.sort1,
  borrowers.sort2,
  Concat_Ws(": ", ALTIDS.description, ALTIDS.attribute) AS ALTID,
  Concat_Ws(": ", CAOTTAWAS.description, CAOTTAWAS.attribute) AS CAOTTAWAS,
  Concat_Ws(": ", EXPIREDS.description, EXPIREDS.attribute) AS EXPIRED,
  Concat_Ws(": ", GRADES.description, GRADES.attribute) AS GRADE,
  Concat_Ws(": ", HOLDS.description, HOLDS.attribute) AS HOLD,
  Concat_Ws(": ", INTERNETS.description, INTERNETS.attribute) AS INTERNET,
  Concat_Ws(": ", LEAVKANOPYS.description, LEAVKANOPYS.attribute) AS LEAVKANOPY,
  Concat_Ws(": ", LICENSES.description, LICENSES.attribute) AS LICENSE,
  Concat_Ws(": ", LOCATIONS.description, LOCATIONS.attribute) AS LOCATION,
  Concat_Ws(": ", MOVIES.description, MOVIES.attribute) AS MOVIE,
  Concat_Ws(": ", NEWSLETTERS.description, NEWSLETTERS.attribute) AS NEWSLETTER,
  Concat_Ws(": ", OTTAKANOPYS.description, OTTAKANOPYS.attribute) AS OTTAKANOPY,
  Concat_Ws(": ", RECEIPTS.description, RECEIPTS.attribute) AS RECEIPT,
  Concat_Ws(": ", REGBRANCHS.description, REGBRANCHS.attribute) AS REGBRANCH,
  Concat_Ws(": ", TEACHERS.description, TEACHERS.attribute) AS TEACHER
FROM
  borrowers LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'ALTID') ALTIDS ON ALTIDS.borrowernumber =
      borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'CAOTTAWA') CAOTTAWAS ON
      CAOTTAWAS.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'EXPIRED') EXPIREDS ON
      EXPIREDS.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'INTERNET') INTERNETS ON
      INTERNETS.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'LEAVKANOPY') LEAVKANOPYS ON
      LEAVKANOPYS.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'LICENSE') LICENSES ON
      LICENSES.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'Location') LOCATIONS ON
      LOCATIONS.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'GRADE') GRADES ON GRADES.borrowernumber =
      borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'HOLD') HOLDS ON HOLDS.borrowernumber =
      borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'MOVIE') MOVIES ON MOVIES.borrowernumber =
      borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'NEWSLETTER') NEWSLETTERS ON
      NEWSLETTERS.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'OTTAKANOPY') OTTAKANOPYS ON
      OTTAKANOPYS.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'RECEIPT') RECEIPTS ON
      RECEIPTS.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'REGBRANCH') REGBRANCHS ON
      REGBRANCHS.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attribute_types.description
    FROM
      borrower_attributes LEFT JOIN
      borrower_attribute_types ON borrower_attributes.code =
          borrower_attribute_types.code
    WHERE
      borrower_attributes.code = 'TEACHER') TEACHERS ON
      TEACHERS.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Enter borrower's home library|ZBRAN>> AND
  borrowers.categorycode LIKE <<Enter borrower's category|LBORROWERCAT>>
ORDER BY
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.othernames



