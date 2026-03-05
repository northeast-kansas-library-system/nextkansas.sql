/*
R.003623

----------

Name: GHW -Unseen report-a-problem notes by borrower branchcode
Created by: George Williams

----------

Group: -
     -

Created on: 2021-11-09 01:09:14
Modified on: 2021-11-09 01:40:13
Date last run: 2024-11-25 12:40:14

----------

Public: 0
Expiry: 300

----------

/cgi-bin/koha/circ/checkout-notes.pl

----------
*/



SELECT
  Concat(
      'Link to problem notes table'
    ) AS LINK,
  Concat_Ws("", 
    Concat("Borrower BC: ", borrowers.cardnumber, ""), 
    Concat(
      'Link to patron record'
    )
  ) AS PATRON,
  Concat_Ws("", 
    Concat("Item home: ", items.homebranch), Concat("Location: ", items.location), 
    Concat("Item type: ", items.itype), Concat("Collection: ", items.ccode), 
    Concat("Call number: ", items.itemcallnumber), Concat("Author: ", biblio.author),
    Concat("Title: ", biblio.title), 
    Concat("Item BC: ", allissues.ITEM_BC, ""), 
    Concat(
      'Link to title'
    )
  ) AS ITEM_INFO,
  Concat_Ws("", 
    Concat("Checked out at: ", allissues.branchcode, ""), 
    Concat("Checked out on: ", allissues.issuedate, ""), 
    Concat("Due date: ", allissues.IN_OR_OUT)
  ) AS CHECKOUT_INFO,
  Concat_Ws("", 
    Concat("Note date: ", allissues.notedate, ""),
    Concat("Note text:", allissues.note)
  ) AS NOTE_INFO
FROM
  (SELECT
     issues.note,
     issues.borrowernumber,
     issues.notedate,
     items.barcode AS ITEM_BC,
     If(issues.itemnumber &lt;&gt; 0, issues.date_due,
     "Item has already been returned") AS IN_OR_OUT,
     issues.branchcode,
     issues.issuedate,
     issues.itemnumber,
     issues.noteseen
   FROM
     issues LEFT JOIN
     items ON issues.itemnumber = items.itemnumber
   WHERE
     issues.note IS NOT NULL AND
     issues.noteseen = 0) AS allissues JOIN
  borrowers ON allissues.borrowernumber = borrowers.borrowernumber LEFT JOIN
  items ON allissues.itemnumber = items.itemnumber JOIN
  biblio ON items.biblionumber = biblio.biblionumber
WHERE
  allissues.branchcode LIKE &lt;&gt;
GROUP BY
  allissues.borrowernumber,
  items.itemnumber,
  allissues.branchcode
ORDER BY
  allissues.notedate DESC

























