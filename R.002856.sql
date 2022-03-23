/*
R.002856

----------

Name: GHW - Sent Overdue Notices
Created by: George H Williams

----------

Group: Notices
     -

Created on: 2016-12-15 11:27:46
Modified on: 2018-12-14 12:32:55
Date last run: 2022-03-21 10:50:48

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows overdue notices automatically sent by Koha</p>
<ul><li>shows notices sent during the date range you specify</li>
<li>shows notices sent by the library you specify</li>
<li>allows you to specify notices sent as print notices, notices sent as e-mail, or both</li>
<li>allows you to print Overdue notice 1, Overdue notice 2, or Overdue notice 3 or any combination of these notices</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report was created to work with the new notices NExpress will start using on January 1, 2016.</p>
<p>You should run the report and then download the results into Excel or another spreadsheet program.  The results will be very hard to read on the screen in Koha.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2856&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  message_queue.content
FROM
  message_queue
WHERE
  (message_queue.letter_code LIKE <<Enter|ZODUE1>> or message_queue.letter_code LIKE <<Enter|ZODUE2>> or message_queue.letter_code LIKE <<Enter|ZODUE3>>) AND
  message_queue.message_transport_type LIKE <<Type of notice|ZTRANSPORT>> AND
  (message_queue.time_queued BETWEEN <<between the beginning of the day on START DATE|date>>  AND (<<and the end of the day on END DATE|date>>+ INTERVAL 1 DAY)) AND
  message_queue.subject LIKE <<Choose location|ZNOTICEB>>
GROUP BY
  message_queue.time_queued, message_queue.content

























