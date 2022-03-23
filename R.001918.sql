/*
R.001918

----------

Name: Circ History for a Patron (Complete)
Created by: Heather Braum

----------

Group: Borrowers
     -

Created on: 2013-06-24 16:03:51
Modified on: 2022-02-07 23:40:17
Date last run: 2022-02-07 23:42:00

----------

Public: 0
Expiry: 0

----------

Full Report

----------
*/



SELECT
  borrowers.cardnumber,
  Concat(
    '<a class="btn btn-default" href="/cgi-bin/koha/members/readingrec.pl?borrowernumber=', 
    borrowers.borrowernumber, 
    '" target="_blank">Go to borrower\'s history</a>'
  ) AS GO_TO_HISTORY
FROM
  borrowers
WHERE
  borrowers.cardnumber = <<Enter library card number>>

























