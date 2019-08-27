/*
R.003254

----------

Name: Report testing - 350
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-18 22:03:31
Modified on: 2019-08-18 23:53:57
Date last run: 2019-08-19 15:38:52

----------

Public: 0
Expiry: 300

----------



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
  issues.branchcode = <<Pick your branch|branches>>
ORDER BY
  borrowers.surname,
  "borrowers.surname",
  issues.date_due



