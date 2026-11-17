/*
R.004006

----------

Name: GHW - Get borrower name
Created by: George Williams

----------

Group: -
     -

Created on: 2026-11-03 11:58:45
Modified on: 2026-11-03 11:58:45
Date last run: 2026-11-16 18:01:01

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Group_Concat('<li class="nsc_borrower_name">', borrowers.surname, ', ', borrowers.firstname, '</li>') AS BORROWER_NAME
FROM
  borrowers
WHERE
  borrowers.borrowernumber = <<borrowernumber>>

























