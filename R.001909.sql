/*
R.001909

----------

Name: Message Queue table (all notices)
Created by: Heather Braum

----------

Group: Borrowers
     -

Created on: 2013-06-11 16:20:56
Modified on: 2023-10-16 22:04:51
Date last run: 2024-01-31 11:33:22

----------

Public: 0
Expiry: 300

----------

 
Generates a list of notices sent to borrowers with a particular home library.
Shows messages sent in the last 180 days
To borrowers with the home library you specify
grouped and sorted by message ID
links to the borrower's account

Notes:

Older report updated by GHW on 2022-07-26.


 

----------
*/



SELECT
  message_queue.message_id,
  Concat(
    '', 
    borrowers.borrowernumber,
    ''
  ) AS LINK_TO_BORROWER,
  borrowers.borrowernumber,
  borrowers.branchcode,
  message_queue.subject,
  Replace(message_queue.content, '&lt;', '&lt;')  AS CONTENT, 
  message_queue.metadata,
  message_queue.letter_code,
  message_queue.message_transport_type,
  message_queue.status,
  message_queue.time_queued,
  message_queue.to_address,
  message_queue.from_address,
  message_queue.content_type
FROM
  message_queue LEFT JOIN
  borrowers ON borrowers.borrowernumber = message_queue.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt;
GROUP BY
  message_queue.message_id
ORDER BY
  message_queue.time_queued DESC

























