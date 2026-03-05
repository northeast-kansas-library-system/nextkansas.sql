/*
R.003231

----------

Name: GHW - Borrower messages
Created by: George Williams

----------

Group: Borrowers
     -

Created on: 2019-07-22 09:28:39
Modified on: 2024-01-17 12:08:28
Date last run: 2024-04-15 09:30:59

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows messages on a specific patron's account&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current messages&lt;/li&gt;
&lt;li&gt;For the patron you specify&lt;/li&gt;
&lt;li&gt;grouped by message ID&lt;/li&gt;
&lt;li&gt;sorted by patron home library, patron last name, patron card number, and branchcode of the library that created the message&lt;/li&gt;
&lt;li&gt;links to the patron check-out page and includes a delete link for each individual message&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3231&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat_Ws('',
    Concat('Card: ', patron.cardnumber),
    Concat('Last name: ', patron.surname),
    Concat('Open patron in new window')
  ) AS PATRON,
  Concat_Ws('',
    Concat('Created by: ', If(messages.manager_id IS NULL, '-', staff.userid)),
    Concat('At: ', messages.branchcode),
    Concat('On: ', messages.message_date)
  ) AS INFO,
  messages.message,
  Concat(
    'Remove this message'
  ) AS REMOVE
FROM borrowers patron
JOIN messages ON messages.borrowernumber = patron.borrowernumber
  LEFT JOIN borrowers staff ON messages.manager_id = staff.borrowernumber
WHERE
  messages.branchcode LIKE &lt;&gt; AND
  patron.cardnumber LIKE Concat('%', &lt;&gt;, '%')
GROUP BY
  messages.message_id
ORDER BY
  patron.branchcode,
  patron.surname,
  patron.cardnumber,
  messages.branchcode

























