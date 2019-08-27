/*
R.002765

----------

Name: GHW - TEST
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-09-07 23:23:17
Modified on: 2016-09-07 23:23:17
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  borrowers.surname,
  borrowers.firstname,
  GROUP_CONCAT(borrowers.cardnumber SEPARATOR ', ') AS barcodes,
  GROUP_CONCAT(borrowers.borrowernumber SEPARATOR ', ') AS borrowers,
  GROUP_CONCAT(borrowers.branchcode SEPARATOR ', ') AS "home libraries"
FROM
  borrowers
GROUP BY
  Concat(borrowers.surname, '-', borrowers.firstname, '/')
HAVING
  Count(Concat(borrowers.surname, '-', borrowers.firstname, '/')) > 1



