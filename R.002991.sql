/*
R.002991

----------

Name: GHW - Patron Lists
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-08-16 21:52:18
Modified on: 2019-07-17 11:44:25
Date last run: 2021-12-14 15:20:42

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
  patron_lists
  INNER JOIN patron_list_patrons ON patron_list_patrons.patron_list_id = patron_lists.patron_list_id
  INNER JOIN borrowers ON patron_list_patrons.borrowernumber = borrowers.borrowernumber
ORDER BY
  patron_lists.name,
  borrowers.surname,
  borrowers.firstname

























