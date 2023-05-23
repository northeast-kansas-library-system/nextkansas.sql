/*
R.000350

----------

Name: Overdue List - XX days past due
Created by: -

----------

Group: Circulation
     Overdues

Created on: 2009-03-16 15:46:05
Modified on: 2023-03-29 10:38:03
Date last run: 2023-05-22 13:07:12

----------

Public: 0
Expiry: 0

----------

Do not Edit. Just Run.
See Report 1078 for Overdue List by Date Range.

----------
*/



SELECT
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode AS "home library",
  borrowers.phone,
  borrowers.cardnumber,
  borrowers.email,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.zipcode,
  issues.date_due,
  (To_Days(CurDate()) - To_Days(issues.date_due)) AS 'days overdue',
  items.itype,
  items.itemcallnumber,
  items.barcode AS barcode,
  items.replacementprice,
  items.homebranch,
  biblio.title,
  biblio.author
FROM
  borrowers
  JOIN issues
    ON issues.borrowernumber = borrowers.borrowernumber
  JOIN items
    ON items.itemnumber = issues.itemnumber
  JOIN biblio
    ON biblio.biblionumber = items.biblionumber
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber
WHERE
  (To_Days(CurDate()) - To_Days(issues.date_due)) > <<number of days>> AND
  issues.branchcode = <<Choose your library|branches>>
ORDER BY
  borrowers.surname,
  "borrowers.surname",
  issues.date_due

























