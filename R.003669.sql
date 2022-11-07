/*
R.003669

----------

Name: test
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-10-05 12:15:39
Modified on: 2022-10-20 15:17:16
Date last run: 2022-10-20 15:17:25

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    '<a class="btn btn-default btn-xs noprint"', 
    'href="/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=', 
    borrowers.borrowernumber, 
    '\" target="_blank">', 
    '<i class="fa fa-pencil" aria-hidden="true"></i> Edit borrower</a>'
  ) AS EDIT,
  Concat_Ws(' ', 
    borrowers.surname, 
    '/', 
    borrowers.firstname,
    If(
      borrowers.othernames = '', 
      '', 
      Concat('(', borrowers.othernames, ')')
    ),
    IF(borrowers.dateofbirth IS NULL, '', Concat('<br /><span style="text-decoration: underline;">Birthdate:</span> ', borrowers.dateofbirth))
  ) AS IDENTITY,
  Concat_Ws('<br />', 
    Concat(borrowers.address, If(borrowers.address2 = '', '', Concat('<br />', borrowers.address2))), 
    Concat(
      If(borrowers.city = '', '', Concat(borrowers.city, ', ')), 
      If(borrowers.state = '', '', Concat(borrowers.state, ' ')), 
      If(borrowers.zipcode = '', '', borrowers.zipcode)
    )
  ) AS MAIN_ADDRESS,
  Concat_Ws('', 
    If(borrowers.phone = '', '', Concat('<i class="fa fa-phone-square fa-lg" aria-hidden="true" style="color: green;"></i> ', borrowers.phone, '<br />')), 
    If(borrowers.phonepro = '', '', Concat('<i class="fa fa-phone-square" aria-hidden="true" style="color: green;"></i> ', borrowers.phonepro, '<br />')),
    IF(borrowers.email = '', '', CONCAT('<i class="fa fa-envelope fa-lg" aria-hidden="true" style="color: blue;"></i> ', borrowers.email, '<br />')),
    IF(borrowers.emailpro = '', '', CONCAT('<i class="fa fa-envelope" aria-hidden="true" style="color: blue;"></i> ', borrowers.emailpro, '<br />'))
  ) AS CONTACT_INFO,
  CONCAT_WS('<br />',
    Concat('Card number: ', borrowers.cardnumber), 
    Concat('Library: ', branches.branchname),
    Concat('Category: ', categories.description)
  ) AS LIBRARY_MANAGEMENT,
  CONCAT_WS('<br />',
    Concat('Registration date: ', borrowers.dateenrolled), 
    Concat('Expiration date: ', borrowers.dateexpiry)
  ) AS LIBRARY_SETUP,
  If(borrowers.smsalertnumber = '', '', Concat('Provider: ', sms_providers.name, '<br />SMS number: ', borrowers.smsalertnumber)) AS SMS,
  @SortOrder := <<Sort by|XS_BORROWER>> AS SORTING
FROM
  borrowers LEFT JOIN
  sms_providers ON borrowers.sms_provider_id = sms_providers.id LEFT JOIN
  branches ON borrowers.branchcode = branches.branchcode LEFT JOIN
  categories ON borrowers.categorycode = categories.categorycode
WHERE
  borrowers.branchcode LIKE <<Choose the patron home library|LBRANCH>> AND
  Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) AND 
  Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH)
GROUP BY
  borrowers.borrowernumber
ORDER BY
  (CASE WHEN SORTING = 13 THEN borrowers.dateofbirth END) DESC,
  (CASE WHEN SORTING = 12 THEN borrowers.dateexpiry END) DESC,
  (CASE WHEN SORTING = 11 THEN borrowers.dateenrolled END) DESC,
  (CASE WHEN SORTING = 10 THEN borrowers.surname END) DESC,
  (CASE WHEN SORTING = 9 THEN borrowers.dateofbirth END) ASC,
  (CASE WHEN SORTING = 8 THEN borrowers.dateexpiry END) ASC,
  (CASE WHEN SORTING = 7 THEN borrowers.dateenrolled END) ASC,
  (CASE WHEN SORTING = 6 THEN borrowers.zipcode END) ASC,
  (CASE WHEN SORTING = 5 THEN borrowers.city END) ASC,
  (CASE WHEN SORTING = 4 THEN borrowers.state END) ASC,
  (CASE WHEN SORTING = 3 THEN borrowers.surname END) ASC,
  (CASE WHEN SORTING = 2 THEN categories.description END) ASC,
  (CASE WHEN SORTING = 1 THEN branches.branchname END) ASC,
  branches.branchname,
  categories.description,
  borrowers.surname, 
  borrowers.firstname, 
  borrowers.state,
  borrowers.city,
  borrowers.address,
  borrowers.zipcode,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  borrowers.dateofbirth
LIMIT 1000

























