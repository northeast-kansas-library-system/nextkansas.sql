/*
R.003075

----------

Name: GHW - Re-categorize borrowers ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-04-17 17:38:36
Modified on: 2021-07-26 14:58:23
Date last run: 2021-07-26 14:58:28

----------

Public: 0
Expiry: 300

----------

Special project for 2018.04.20 afternoon

----------
*/

SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.categorycode,
  borrowers.dateofbirth,
  If(Date_Format(From_Days(To_Days(Now()) - To_Days(borrowers.dateofbirth)), '%Y') + 0 BETWEEN 0 AND 11, borrowers.cardnumber, "-") AS MINORJ,
  If(Date_Format(From_Days(To_Days(Now()) - To_Days(borrowers.dateofbirth)), '%Y') + 0 = 12, borrowers.cardnumber, "-") AS MINORT,
  If(Date_Format(From_Days(To_Days(Now()) - To_Days(borrowers.dateofbirth)), '%Y') + 0 BETWEEN 13 AND 17, borrowers.cardnumber, "-") AS MINORY,
  If(Date_Format(From_Days(To_Days(Now()) - To_Days(borrowers.dateofbirth)), '%Y') + 0 BETWEEN 0 AND 17, borrowers.cardnumber, "-") AS CHILD,
  Date_Format(From_Days(To_Days(Now()) - To_Days(borrowers.dateofbirth)), '%Y') + 0 AS AGE
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE <<Choose your library|branches>>
GROUP BY
  borrowers.borrowernumber
ORDER BY
  AGE ASC



