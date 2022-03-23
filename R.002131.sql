/*
R.002131

----------

Name: Circ History for a Patron (Simple)
Created by: Heather Braum

----------

Group: Borrowers
     -

Created on: 2013-12-18 16:43:48
Modified on: 2022-02-07 23:40:26
Date last run: 2022-02-17 13:01:00

----------

Public: 0
Expiry: 0

----------

Lists item callnumber, title, author, checked out date

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

























