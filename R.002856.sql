/*
R.002856

----------

Name: GHW - Sent Overdue Notices
Created by: George Williams

----------

Group: Notices
     -

Created on: 2016-12-15 11:27:46
Modified on: 2024-01-17 11:46:43
Date last run: 2025-03-07 17:43:55

----------

Public: 0
Expiry: 0

----------

 
Shows overdue notices automatically sent by Koha
shows notices sent during the date range you specify
shows notices sent by the library you specify
allows you to specify notices sent as print notices, notices sent as e-mail, or both
allows you to print Overdue notice 1, Overdue notice 2, or Overdue notice 3 or any combination of these notices

Notes:

This report was created to work with the new notices NExpress will start using on January 1, 2016.
You should run the report and then download the results into Excel or another spreadsheet program.  The results will be very hard to read on the screen in Koha.


----------
*/



SELECT
  message_queue.content
FROM
  message_queue
WHERE
  (message_queue.letter_code LIKE &lt;&gt; or message_queue.letter_code LIKE &lt;&gt; or message_queue.letter_code LIKE &lt;&gt;) AND
  message_queue.message_transport_type LIKE &lt;&gt; AND
  (message_queue.time_queued BETWEEN &lt;&gt;  AND (&lt;&gt;+ INTERVAL 1 DAY)) AND
  message_queue.subject LIKE &lt;&gt;
GROUP BY
  message_queue.time_queued, message_queue.content

























