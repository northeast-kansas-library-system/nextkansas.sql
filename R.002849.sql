/*
R.002849

----------

Name: GHW - Message Queue test
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-12-09 14:22:58
Modified on: 2016-12-09 14:22:58
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.cardnumber,
  message_queue.content
FROM
  message_queue INNER JOIN
  borrowers
    ON message_queue.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.cardnumber = 'X5G001'

























