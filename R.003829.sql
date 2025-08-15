/*
R.003829

----------

Name: Bounced email or SMS helper
Created by: George Williams

----------

Group: -
     -

Created on: 2024-04-25 09:43:10
Modified on: 2024-05-01 16:05:35
Date last run: 2024-07-17 08:16:10

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  CASE
    WHEN
      SubString(message_queue.to_address FROM 1 FOR 10 ) = borrowers.smsalertnumber
    THEN 'SMS'
    WHEN
      message_queue.to_address = borrowers.email
    THEN 'PRIMARY_EMAIL'
    WHEN
      message_queue.to_address = borrowers.emailpro
    THEN 'SECONDARY_EMAIL'
    ELSE '???'
  END AS SENT_TO,
  borrowers.cardnumber AS LIBRARY_CARD,
  Concat_Ws('', 
    '&lt;br /&gt;', 
    'BOUNCED ', 
    CASE
      WHEN
        message_queue.message_transport_type = 'sms'
      THEN 'SMS TEXT'
      WHEN
        message_queue.message_transport_type = 'email'
      THEN 'E-MAIL'
      ELSE message_queue.message_transport_type
    END, 
    ' MESSAGE', 
    '&lt;br /&gt;', 
    'An ', 
    CASE
      WHEN
        message_queue.message_transport_type = 'sms'
      THEN 'SMS text message'
      WHEN
        message_queue.message_transport_type = 'email'
      THEN 'e-mail'
      ELSE message_queue.message_transport_type
    END, 
    ' sent to this patron at -- ', 
    CASE
      WHEN
        message_queue.message_transport_type = 'sms'
      THEN borrowers.smsalertnumber
      WHEN
        message_queue.message_transport_type = 'email'
      THEN message_queue.to_address
      ELSE message_queue.message_transport_type
    END, 
    ' -- has bounced.', 
    '&lt;br /&gt;',
    'Please confirm and up',
    'date the patron\'s contact information the next time they use their account.', 
    '&lt;br /&gt;', 
    CurDate(), 
    '&lt;br /&gt;'
  ) AS MESSAGE,
  Concat(
    '', 
    borrowers.borrowernumber,
    ''
  ) AS 'LINK_TO_PATRON'
FROM
  borrowers JOIN
  message_queue ON message_queue.borrowernumber = borrowers.borrowernumber
WHERE
  message_queue.to_address LIKE Concat("%", &lt;&gt;, "%")
GROUP BY
  borrowers.borrowernumber

























