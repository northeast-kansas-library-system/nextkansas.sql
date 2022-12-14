/*
R.003231

----------

Name: GHW - Borrower messages
Created by: George H Williams

----------

Group: Borrowers
     -

Created on: 2019-07-22 09:28:39
Modified on: 2019-12-26 16:58:06
Date last run: 2022-12-11 21:05:24

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Shows messages on a specific patron's account</p>
<ul><li>Shows current messages</li>
<li>For the patron you specify</li>
<li>grouped by message ID</li>
<li>sorted by patron home library, patron last name, patron card number, and branchcode of the library that created the message</li>
<li>links to the patron check-out page and includes a delete link for each individual message</li>
</ul><br />
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3231&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat_Ws('<br />',
    Concat('Card: ', patron.cardnumber),
    Concat('Last name: ', patron.surname),
    Concat('<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', patron.borrowernumber, '" target="_blank">Open patron in new window</a>')
  ) AS PATRON,
  Concat_Ws('<br />',
    Concat('Created by: ', If(messages.manager_id IS NULL, '-', staff.userid)),
    Concat('At: ', messages.branchcode),
    Concat('On: ', messages.message_date)
  ) AS INFO,
  messages.message,
  Concat(
    '<a href="/cgi-bin/koha/circ/del_message.pl?message_id=',
    messages.message_id,
    '&borrowernumber=',
    patron.borrowernumber,
    '" target="_blank">Remove this message</a>'
  ) AS REMOVE
FROM borrowers patron
JOIN messages ON messages.borrowernumber = patron.borrowernumber
  LEFT JOIN borrowers staff ON messages.manager_id = staff.borrowernumber
WHERE
  messages.branchcode LIKE <<Choose your library|LBRANCH>> AND
  patron.cardnumber LIKE Concat('%', <<Enter patron barcode number or a % symbol>>, '%')
GROUP BY
  messages.message_id
ORDER BY
  patron.branchcode,
  patron.surname,
  patron.cardnumber,
  messages.branchcode

























