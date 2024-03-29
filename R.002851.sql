/*
R.002851

----------

Name: GHW - Borrowers with Messages at LEAVENWRTH
Created by: George H Williams

----------

Group:  LEAVENWRTH
     -

Created on: 2016-12-12 14:08:07
Modified on: 2021-08-16 20:33:42
Date last run: 2022-12-07 14:11:56

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows patrons at LEAVENWRTH with "messages" on their accounts</p>
<ul><li>Shows patrons currently in Koha</li>
<li>Only shows patrons whose messages were added at LEAVENWRTH</li>
<li>grouped by borrower's cardnumber and message date</li>
<li>contains links to the patron account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2851&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
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
  messages.message
FROM borrowers patron
JOIN messages ON messages.borrowernumber = patron.borrowernumber
  LEFT JOIN borrowers staff ON messages.manager_id = staff.borrowernumber
WHERE
  messages.branchcode LIKE Concat('%', <<Choose your library|LBRANCH>>, '%')
GROUP BY
  messages.message_id
ORDER BY
  patron.branchcode,
  patron.surname,
  patron.cardnumber,
  messages.branchcode

























