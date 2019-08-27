/*
R.003075

----------

Name: GHW - LEAVENWRTH re-categorize borrowers
Created by: George H Williams

----------

Group: Library-Specific
     -

Created on: 2018-04-17 17:38:36
Modified on: 2018-04-17 17:38:36
Date last run: 2018-04-25 12:14:07

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
  If(borrowers.categorycode LIKE "MILADULT", borrowers.cardnumber, "-") AS ADULT,
  Date_Format(From_Days(To_Days(Now()) - To_Days(borrowers.dateofbirth)), '%Y') + 0 AS AGE
FROM
  borrowers
WHERE
  borrowers.branchcode = 'LEAVENWRTH'
GROUP BY
  borrowers.borrowernumber



