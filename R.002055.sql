/*
R.002055

----------

Name: COLL-newdelinq-linked-HIAW
Created by: Robin Hastings

----------

Group:  HIAWATHA
     -

Created on: 2013-10-22 12:15:26
Modified on: 2023-02-09 10:20:33
Date last run: 2022-12-02 10:06:25

----------

Public: 0
Expiry: 0

----------

Linked version of the Unique Report for Hiawatha

----------
*/



SELECT 
  Concat(
    '<a href=\"/cgi-bin/koha/members/maninvoice.pl?borrowernumber=',
    borrowers.borrowernumber,
    '\" target="_blank">',
    borrowers.cardnumber,
    '</a>'
  ) AS "Link to Fines",
  borrowers.borrowernumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.zipcode,
  borrowers.phone,
  borrowers.mobile,
  borrowers.phonepro AS "Alt Ph 1",
  borrowers.B_phone AS "Alt Ph 2",
  borrowers.branchcode,
  categories.category_type AS "Adult or Child",
  borrowers.dateofbirth,
  Max(accountlines.date) AS "Most recent charge",
  Format(Sum(accountlines.amountoutstanding), 2) AS Due
FROM accountlines
  LEFT JOIN borrowers ON borrowers.borrowernumber = accountlines.borrowernumber
  LEFT JOIN categories ON categories.categorycode = borrowers.categorycode
WHERE borrowers.branchcode IN ('HIAWATHA')
  AND borrowers.sort1 != 'yes'
  AND accountlines.date > Date_Sub(CurDate(), INTERVAL 3 YEAR)
  AND accountlines.date < Date_Sub(CurDate(), INTERVAL 60 DAY)
GROUP BY borrowers.borrowernumber
HAVING Due >= 25.00
ORDER BY borrowers.surname

























