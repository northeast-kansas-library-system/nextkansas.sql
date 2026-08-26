/*
R.003979

----------

Name: speedy batch
Created by: George Williams

----------

Group: -
     -

Created on: 2026-08-12 18:04:38
Modified on: 2026-08-12 18:04:38
Date last run: 2026-08-12 18:04:41

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  patron_lists.name,
  patron_list_patrons.borrowernumber,
  borrowers.surname,
  borrowers.firstname
FROM
  patron_list_patrons INNER JOIN
  patron_lists ON patron_list_patrons.patron_list_id =
      patron_lists.patron_list_id INNER JOIN
  borrowers ON patron_list_patrons.borrowernumber = borrowers.borrowernumber
WHERE
  patron_list_patrons.patron_list_id = 122

























