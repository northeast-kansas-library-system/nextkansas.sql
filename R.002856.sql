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
Date last run: 2026-01-28 09:24:43

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows overdue notices automatically sent by Koha&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;shows notices sent during the date range you specify&lt;/li&gt;
&lt;li&gt;shows notices sent by the library you specify&lt;/li&gt;
&lt;li&gt;allows you to specify notices sent as print notices, notices sent as e-mail, or both&lt;/li&gt;
&lt;li&gt;allows you to print Overdue notice 1, Overdue notice 2, or Overdue notice 3 or any combination of these notices&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report was created to work with the new notices NExpress will start using on January 1, 2016.&lt;/p&gt;
&lt;p&gt;You should run the report and then download the results into Excel or another spreadsheet program.  The results will be very hard to read on the screen in Koha.&lt;/p&gt;
&lt;/div&gt;

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

























