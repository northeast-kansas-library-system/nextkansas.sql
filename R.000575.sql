/*
R.000575

----------

Name: OVERDUE LIST - For Shelf Check
Created by:  Tongie Book Club

----------

Group: Circulation
     Overdues

Created on: 2009-06-12 14:19:42
Modified on: 2020-12-08 22:58:11
Date last run: 2021-10-19 10:41:56

----------

Public: 0
Expiry: 0

----------

Simplified report of overdue items for shelf check

----------
*/



SELECT
  borrowers.cardnumber,
  items.barcode,
  items.permanent_location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title
FROM
  borrowers LEFT JOIN
  issues ON issues.borrowernumber = borrowers.borrowernumber LEFT JOIN
  items ON items.itemnumber = issues.itemnumber LEFT JOIN
  biblio ON biblio.biblionumber = items.biblionumber
WHERE
  (To_Days(CurDate()) - To_Days(issues.date_due)) >= '2' AND
  issues.branchcode = <<Choose your library|branches>>
GROUP BY
  borrowers.cardnumber,
  issues.issue_id
ORDER BY
  borrowers.cardnumber,
  items.permanent_location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title

























