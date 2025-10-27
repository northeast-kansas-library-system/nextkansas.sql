/*
R.002858

----------

Name: GHW - Items more than XX days overdue
Created by: George Williams

----------

Group: Fines/Fees
     -

Created on: 2016-12-15 16:10:39
Modified on: 2024-01-17 11:46:41
Date last run: 2025-09-24 11:22:34

----------

Public: 0
Expiry: 0

----------

 
Lists patrons with items more than XX days overdue at a specified library
Shows patrons who currently have overdues
that were checked out at the specified location
grouped by
sorted by patron name, card number, and date due
links to the patron record

Notes:

Report created at the request of HIAWATHA.
Essentially the same as report 350 - just with fewer fields.
Click here to run in a new window


----------
*/



SELECT
  Concat_Ws('', 
    Concat(
      borrowers.firstname, 
      ' ', 
      borrowers.surname
    ),  
    (
      IF(
        borrowers.address2 = "", 
        borrowers.address, 
        Concat(borrowers.address, '', borrowers.address2)
      )
    ), 
    Concat(
      borrowers.city, 
      ', ',  
      borrowers.state, 
      ' ', 
      borrowers.zipcode
    ),
    borrowers.categorycode
  ) AS ADDRESS,
  borrowers.firstname,
  borrowers.surname,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  (To_Days(CurDate()) - To_Days(issues.date_due)) AS DAYS_OVERDUE,
  items.replacementprice
FROM
  borrowers JOIN
  issues
    ON borrowers.borrowernumber = issues.borrowernumber JOIN
  items
    ON issues.itemnumber = items.itemnumber JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  biblioitems
    ON biblio.biblionumber = biblioitems.biblionumber
WHERE
  (To_Days(CurDate()) - To_Days(issues.date_due)) &gt; &lt;&gt; AND
  issues.branchcode LIKE &lt;&gt;
GROUP BY
  items.itemnumber,
  issues.date_due
ORDER BY
  borrowers.surname,
  borrowers.firstname,
  borrowers.cardnumber,
  issues.date_due

























