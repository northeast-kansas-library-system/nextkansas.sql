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

 
Shows messages on a specific patron's account
Shows current messages
For the patron you specify
grouped by message ID
sorted by patron home library, patron last name, patron card number, and branchcode of the library that created the message
links to the patron check-out page and includes a delete link for each individual message


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

























