/*
R.001823

----------

Name: WAC OVERDUES REPORT 
Created by: -

----------

Group: School Libraries
     Overdues (schools)

Created on: 2013-05-02 08:54:12
Modified on: 2019-08-19 23:55:04
Date last run: -

----------

Public: 0
Expiry: 0

----------

(Other than the extended attributes for the schools, I'm not sure this is better than any other overdue report - GHW)

----------
*/

SELECT
  borrower_attributes.attribute AS GRADE,
  borrowers.firstname,
  borrowers.surname,
  borrowers.sort1,
  items.replacementprice,
  biblio.title,
  items.itemcallnumber,
  items.barcode,
  issues.issuedate,
  issues.date_due,
  Concat(
    '<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    borrowers.borrowernumber,
    '\" target="_blank">patron check out</a>'
  ) AS BORROWER_LINK
FROM
  borrowers
  LEFT JOIN borrower_attributes
    ON borrower_attributes.borrowernumber = borrowers.borrowernumber
  LEFT JOIN issues
    ON issues.borrowernumber = borrower_attributes.borrowernumber
  LEFT JOIN items
    ON items.itemnumber = issues.itemnumber
  LEFT JOIN biblio
    ON biblio.biblionumber = items.biblionumber
WHERE
  borrowers.branchcode = 'phwac' AND
  (To_Days(CurDate()) - To_Days(issues.date_due)) >= '1'
GROUP BY
  items.barcode
ORDER BY
  GRADE,
  borrowers.surname,
  items.itemcallnumber



