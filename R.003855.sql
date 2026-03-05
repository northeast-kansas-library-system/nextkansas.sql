/*
R.003855

----------

Name: Koha-US killer report
Created by: George Williams

----------

Group: -
     -

Created on: 2024-08-13 00:09:19
Modified on: 2024-08-13 00:09:19
Date last run: 2024-08-13 00:09:43

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  concat_WS('<br />',
    concat('Account summary: ', 

  borrowers.firstname,
  ' ',
  if(borrowers.othernames != '', concat(' (', borrowers.othernames, ') '), ''),
  borrowers.surname,
  ' (', 
  borrowers.cardnumber, ')'),
  if(borrowers.address2 = '', borrowers.address, concat(borrowers.address, '<br />', borrowers.address2)),
  concat(borrowers.city, ', ', borrowers.state, ' ', borrowers.zipcode),
  borrowers.phone,
  borrowers.email,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  borrowers.branchcode,
  borrowers.categorycode
  ) AS BORROWER
FROM
  borrowers
WHERE
  borrowers.borrowernumber = 182125

























