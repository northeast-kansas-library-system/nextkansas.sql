/*
R.003802

----------

Name: Bad text numbers
Created by: George Williams

----------

Group: -
     -

Created on: 2024-02-23 15:40:25
Modified on: 2025-02-20 14:19:12
Date last run: 2025-10-27 09:30:49

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    'https://staff.nekls.bywatersolutions.com/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=', 
    borrowers.borrowernumber, 
    '&step=5'
  ) AS BORROWER_URL,
  borrowers.branchcode,
  Concat(
    '&amp;lt;br>TEXT MESSAGE NUMBER REMOVED&amp;lt;br>The text message number ', 
    borrowers.smsalertnumber, 
    ' has been removed from this account because it is not a complete text messaging number.&amp;lt;br>', 
    'All text message numbers must be 10 digit phone numbers in order for the text messaging system to work properly.&amp;lt;br>', 
    'GHW - NEKLS ', 
    Now(), 
    '&amp;lt;br>'
  ) AS MESSAGE,
  Length(borrowers.smsalertnumber) AS smsalertnumber,
  borrowers.sms_provider_id
FROM
  borrowers
WHERE
  Length(borrowers.smsalertnumber) BETWEEN 1 AND 9
ORDER BY
  borrowers.branchcode

























