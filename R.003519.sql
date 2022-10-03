/*
R.003519

----------

Name: sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-06-11 09:57:11
Modified on: 2022-07-26 14:44:53
Date last run: 2022-07-26 15:43:37

----------

Public: 0
Expiry: 300

----------

Setup for 942 cleanup - item type = NVIDEO


----------
*/



SELECT
  message_queue.message_id,
  Concat(
    '<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    borrowers.borrowernumber, 
    '\" target="_blank">', 
    borrowers.borrowernumber,
    '</a>'
  ) AS LINK_TO_BORROWER,
  borrowers.borrowernumber,
  borrowers.branchcode,
  message_queue.subject,
  Replace(message_queue.content, '<', '&lt;')  AS CONTENT, 
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
  borrowers.branchcode = <<choose branch|branches>>
GROUP BY
  message_queue.message_id
ORDER BY
  message_queue.time_queued DESC

























