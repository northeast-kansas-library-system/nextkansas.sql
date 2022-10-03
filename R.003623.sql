/*
R.003623

----------

Name: GHW -Unseen report-a-problem notes by borrower branchcode
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-11-09 01:09:14
Modified on: 2021-11-09 01:40:13
Date last run: 2022-10-03 13:41:22

----------

Public: 0
Expiry: 300

----------

/cgi-bin/koha/circ/checkout-notes.pl

----------
*/



SELECT
  Concat(
      '<a href=\"/cgi-bin/koha/circ/checkout-notes.pl" target="_blank">Link to problem notes table</a>'
    ) AS LINK,
  Concat_Ws("<br />", 
    Concat("Borrower BC: ", borrowers.cardnumber, "<br />"), 
    Concat(
      '<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=', 
      allissues.borrowernumber, 
      '\" target="_blank">Link to patron record</a>'
    )
  ) AS PATRON,
  Concat_Ws("<br />", 
    Concat("Item home: ", items.homebranch), Concat("Location: ", items.location), 
    Concat("Item type: ", items.itype), Concat("Collection: ", items.ccode), 
    Concat("Call number: ", items.itemcallnumber), Concat("Author: ", biblio.author),
    Concat("Title: ", biblio.title), 
    Concat("Item BC: ", allissues.ITEM_BC, "<br />"), 
    Concat(
      '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
      items.biblionumber, 
      '\" target="_blank">Link to title</a>'
    )
  ) AS ITEM_INFO,
  Concat_Ws("<br />", 
    Concat("Checked out at: ", allissues.branchcode, "<br />"), 
    Concat("Checked out on: ", allissues.issuedate, "<br />"), 
    Concat("Due date: ", allissues.IN_OR_OUT)
  ) AS CHECKOUT_INFO,
  Concat_Ws("<br />", 
    Concat("Note date: ", allissues.notedate, "<br />"),
    Concat("<ins>Note text:</ins><br /><br />", allissues.note)
  ) AS NOTE_INFO
FROM
  (SELECT
     issues.note,
     issues.borrowernumber,
     issues.notedate,
     items.barcode AS ITEM_BC,
     If(issues.itemnumber <> 0, issues.date_due,
     "<span style='color: red;'><ins>Item has already been returned</ins></span>") AS IN_OR_OUT,
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
  allissues.branchcode LIKE <<Enter branchcode>>
GROUP BY
  allissues.borrowernumber,
  items.itemnumber,
  allissues.branchcode
ORDER BY
  allissues.notedate DESC

























