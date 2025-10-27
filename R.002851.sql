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

 
Shows patrons at LEAVENWRTH with "messages" on their accounts
Shows patrons currently in Koha
Only shows patrons whose messages were added at LEAVENWRTH
grouped by borrower's cardnumber and message date
contains links to the patron account

Notes:

Click here to run in a new window



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

























