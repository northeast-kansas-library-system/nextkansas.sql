/*
R.003874

----------

Name: GHW - sandbox
Created by: George Williams

----------

Group: -
     -

Created on: 2025-01-16 09:38:14
Modified on: 2025-01-16 11:16:04
Date last run: 2025-01-16 11:16:04

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws(
    '', 
    Concat('User id: ', borrowers.cardnumber), 
    Concat('Name: ', Concat(borrowers.surname, ' / ', borrowers.firstname)), 
    Concat('e-mail: ', borrowers.email), 
    Concat_Ws(
      '',
      'URL for p', 
      'assword reset: https://staff.nekls.bywatersolutions.com/cgi-bin/koha/members/notices.pl?borrowernumber=', 
      borrowers.borrowernumber, 
      '&op=send_p',
      'assword_reset'
    )
  ) AS INFO
FROM
  patron_list_patrons JOIN
  borrowers ON patron_list_patrons.borrowernumber = borrowers.borrowernumber
WHERE
  patron_list_patrons.patron_list_id = 407
ORDER BY 
  borrowers.surname ASC

























