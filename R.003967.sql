/*
R.003967

----------

Name: SENECA zip code report - work in progress
Created by: George Williams

----------

Group:  SENECA
     -

Created on: 2026-07-20 14:59:59
Modified on: 2026-07-20 15:05:59
Date last run: 2026-07-20 15:07:16

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers_to_Modify.borrowernumber,
  borrowers_to_Modify.cardnumber,
  borrowers_to_Modify.categorycode,
  borrowers_to_Modify.ACCESS_TYPE
FROM
  (SELECT
      borrowers.borrowernumber,
      borrowers.cardnumber,
      borrowers.categorycode,
      If(borrowers.categorycode = 'OTHERADULT', ' Modify category to "Adult"',
      ' Modify category to "Minor - (age 00-17)"') AS ACCESS_TYPE
    FROM
      borrowers
    WHERE
      borrowers.branchcode = 'SENECA' AND
      (borrowers.categorycode = 'OTHERADULT' OR
        borrowers.categorycode = 'OTHERCHILD') AND
      (Left(Trim(borrowers.zipcode), 5) = '66404' OR
        Left(Trim(borrowers.zipcode), 5) = '66408' OR
        Left(Trim(borrowers.zipcode), 5) = '66415' OR
        Left(Trim(borrowers.zipcode), 5) = '66417' OR
        Left(Trim(borrowers.zipcode), 5) = '66428' OR
        Left(Trim(borrowers.zipcode), 5) = '66522' OR
        Left(Trim(borrowers.zipcode), 5) = '66534' OR
        Left(Trim(borrowers.zipcode), 5) = '66538' OR
        Left(Trim(borrowers.zipcode), 5) = '66550')
    GROUP BY
      borrowers.borrowernumber,
      borrowers.categorycode
    UNION
    SELECT
      borrowers.borrowernumber,
      borrowers.cardnumber,
      borrowers.categorycode,
      If(borrowers.categorycode = 'ADULT', 'Modify category to "Adult - other"',
      'Modify category to "Minor - other (age 00-17)"') AS ACCESS_TYPE
    FROM
      borrowers
    WHERE
      borrowers.branchcode = 'SENECA' AND
      (borrowers.categorycode = 'ADULT' OR
        borrowers.categorycode = 'CHILD') AND
      Left(Trim(borrowers.zipcode), 5) != '66404' AND
      Left(Trim(borrowers.zipcode), 5) != '66408' AND
      Left(Trim(borrowers.zipcode), 5) != '66415' AND
      Left(Trim(borrowers.zipcode), 5) != '66417' AND
      Left(Trim(borrowers.zipcode), 5) != '66428' AND
      Left(Trim(borrowers.zipcode), 5) != '66522' AND
      Left(Trim(borrowers.zipcode), 5) != '66534' AND
      Left(Trim(borrowers.zipcode), 5) != '66538' AND
      Left(Trim(borrowers.zipcode), 5) != '66550'
    GROUP BY
      borrowers.borrowernumber,
      borrowers.categorycode
    ORDER BY
      ACCESS_TYPE) borrowers_to_Modify
WHERE
  borrowers_to_Modify.categorycode LIKE  <<Choose a category|categorycode:all>> 

























