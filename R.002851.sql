/*
R.002851

----------

Name: GHW - Borrowers with Messages at LEAVENWRTH
Created by: George Williams

----------

Group:  LEAVENWRTH
     -

Created on: 2016-12-12 14:08:07
Modified on: 2024-01-17 11:46:50
Date last run: 2025-10-09 09:37:23

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows patrons at LEAVENWRTH with "messages" on their accounts&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows patrons currently in Koha&lt;/li&gt;
&lt;li&gt;Only shows patrons whose messages were added at LEAVENWRTH&lt;/li&gt;
&lt;li&gt;grouped by borrower's cardnumber and message date&lt;/li&gt;
&lt;li&gt;contains links to the patron account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2851&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
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
  messages.message
FROM borrowers patron
JOIN messages ON messages.borrowernumber = patron.borrowernumber
  LEFT JOIN borrowers staff ON messages.manager_id = staff.borrowernumber
WHERE
  messages.branchcode LIKE Concat('%', &lt;&gt;, '%')
GROUP BY
  messages.message_id
ORDER BY
  patron.branchcode,
  patron.surname,
  patron.cardnumber,
  messages.branchcode

























