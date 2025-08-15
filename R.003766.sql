/*
R.003766

----------

Name: GHW - Check Digests
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-13 12:46:41
Modified on: 2025-02-20 14:17:37
Date last run: 2025-08-14 08:22:06

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws('',
    'https://staff.nekls.bywatersolutions.com/cgi-bin/koha/members/moremember.pl?borrowernumber=', 
    borrower_message_preferences.borrowernumber, 
    '&step=5'
  ) AS URL
FROM
  borrower_message_preferences LEFT JOIN borrower_message_transport_preferences 
    ON
  borrower_message_transport_preferences.borrower_message_preference_id = borrower_message_preferences.borrower_message_preference_id
WHERE
  borrower_message_preferences.wants_digest = 0 
    AND
  (
    borrower_message_preferences.message_attribute_id = 1 
      OR 
    borrower_message_preferences.message_attribute_id = 2 
      OR 
    borrower_message_preferences.message_attribute_id = 4
  ) 
    AND
  (
    borrower_message_transport_preferences.message_transport_type = 'email' 
      OR
    borrower_message_transport_preferences.message_transport_type = 'sms'
  )
GROUP BY
  borrower_message_preferences.borrowernumber
LIMIT 15

























