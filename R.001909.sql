/*
R.001909

----------

Name: Message Queue table (all notices)
Created by: Heather Braum

----------

Group: Borrowers
     -

Created on: 2013-06-11 16:20:56
Modified on: 2022-07-27 09:42:48
Date last run: 2022-08-18 11:38:39

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates a list of notices sent to borrowers with a particular home library.</p>
<ul><li>Shows messages sent in the last 180 days</li>
<li>To borrowers with the home library you specify</li>
<li>grouped and sorted by message ID</li>
<li>links to the borrower's account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Older report updated by GHW on 2022-07-26.</p>
<p></p>
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div> 

----------
*/



SELECT
  message_queue.message_id,
  Concat(
    '<a href=\"/cgi-bin/koha/members/notices.pl?borrowernumber=',
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
  borrowers.branchcode LIKE <<choose branch|ZBRAN>>
GROUP BY
  message_queue.message_id
ORDER BY
  message_queue.time_queued DESC

























