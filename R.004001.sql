/*
R.004001

----------

Name: GHW - PH password update
Created by: George Williams

----------

Group: -
     -

Created on: 2026-09-28 09:58:58
Modified on: 2026-09-28 10:00:42
Date last run: 2026-10-01 08:05:25

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.middle_name,
  borrowers.branchcode,
  borrowers.categorycode,
  'BlueJays1!' as 'assword'
FROM
  borrowers
WHERE
  borrowers.surname != 'Test' AND
  borrowers.surname != 'Frosty' AND
  borrowers.branchcode LIKE "PHS%" AND
  borrowers.categorycode = 'TEACHER'

























