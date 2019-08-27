/*
R.003049

----------

Name: GHW - Child accounts with no guarantor information
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-02-08 14:03:22
Modified on: 2018-02-08 14:14:33
Date last run: 2018-02-08 14:46:32

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">Patron record</a>') AS LINK,
  borrowers.cardnumber,
  Concat(borrowers.surname, ", ", borrowers.firstname) AS NAME,
  borrowers.dateofbirth,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  (TimestampDiff(DAY, borrowers.dateofbirth, CurDate())) / 365.25 AS AGE,
  borrowers.borrowernotes,
  messages.message
FROM
  borrowers
  LEFT JOIN (SELECT
        categories.categorycode,
        categories.category_type
      FROM
        categories) categoryx ON borrowers.categorycode = categoryx.categorycode
  LEFT JOIN messages ON borrowers.borrowernumber = messages.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Your library|ZBRAN>> AND
  (borrowers.contactname IS NULL OR
    borrowers.contactname = " ") AND
  (borrowers.guarantorid < 1 OR
    borrowers.guarantorid IS NULL) AND
  categoryx.category_type = 'C' AND
  (TimestampDiff(DAY, borrowers.dateofbirth, CurDate())) / 365.25 BETWEEN <<Patron's age is between>> AND <<and>>
GROUP BY
  borrowers.cardnumber,
  messages.message_id
ORDER BY
  NAME



