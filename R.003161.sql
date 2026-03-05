/*
R.003161

----------

Name: GHW - Patrons added in the previous calendar month
Created by: George Williams

----------

Group: -
     -

Created on: 2019-01-27 23:01:25
Modified on: 2025-05-17 00:05:11
Date last run: 2026-01-12 15:43:56

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of new patrons to review for input errors&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows patrons added in the previous calendar month&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by the patron's last name and first name&lt;/li&gt;
&lt;li&gt;contains links to the edit patron screen for each patron&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Partially replaces report 555&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat(
    'Edit account'
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
    IF(borrowers.dateofbirth IS NULL, '', Concat('Birthdate: ', borrowers.dateofbirth))
  ) AS IDENTITY,
  Concat_Ws('', 
    Concat(borrowers.address, If(borrowers.address2 = '', '', Concat('', borrowers.address2))), 
    Concat(
      If(borrowers.city = '', '', Concat(borrowers.city, ', ')), 
      If(borrowers.state = '', '', Concat(borrowers.state, ' ')), 
      If(borrowers.zipcode = '', '', borrowers.zipcode)
    )
  ) AS MAIN_ADDRESS,
  Concat_Ws('', 
    If(borrowers.phone = '', '', Concat(' ', borrowers.phone, '')), 
    If(borrowers.phonepro = '', '', Concat(' ', borrowers.phonepro, '')),
    IF(borrowers.email = '', '', CONCAT(' ', borrowers.email, '')),
    IF(borrowers.emailpro = '', '', CONCAT(' ', borrowers.emailpro, ''))
  ) AS CONTACT_INFO,
  CONCAT_WS('',
    Concat('Card number: ', borrowers.cardnumber), 
    Concat('Library: ', branches.branchname),
    Concat('Category: ', categories.description)
  ) AS LIBRARY_MANAGEMENT,
  CONCAT_WS('',
    Concat('Registration date: ', borrowers.dateenrolled), 
    Concat('Expiration date: ', borrowers.dateexpiry)
  ) AS LIBRARY_SETUP,
  If(borrowers.smsalertnumber = '', '', Concat('Provider: ', sms_providers.name, 'SMS number: ', borrowers.smsalertnumber)) AS SMS,
  @SortOrder := &lt;&gt; AS SORTING
FROM
  borrowers LEFT JOIN
  sms_providers ON borrowers.sms_provider_id = sms_providers.id LEFT JOIN
  branches ON borrowers.branchcode = branches.branchcode LEFT JOIN
  categories ON borrowers.categorycode = categories.categorycode
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
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

























