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

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of notices sent to borrowers with a particular home library.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows messages sent in the last 180 days&lt;/li&gt;
&lt;li&gt;To borrowers with the home library you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by message ID&lt;/li&gt;
&lt;li&gt;links to the borrower's account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Older report updated by GHW on 2022-07-26.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;
&lt;/div&gt; 

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

























