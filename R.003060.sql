/*
R.003060

----------

Name: GHW - "Report-a-problem" notes by item barcode
Created by: George Williams

----------

Group: -
     -

Created on: 2018-03-07 17:06:32
Modified on: 2018-03-08 13:34:05
Date last run: 2018-08-27 15:31:20

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws("",
    Concat("Borrower BC: ", borrowers.cardnumber, ""),
    Concat('Link to patron record')
  ) AS PATRON,
  Concat_Ws("",
    Concat("Item home: ", items.homebranch),
    Concat("Location: ", items.location),
    Concat("Item type: ", items.itype),
    Concat("Collection: ", items.ccode),
    Concat("Call number: ", items.itemcallnumber),
    Concat("Author: ", biblio.author),
    Concat("Title: ", biblio.title),
    Concat("Item BC: ", allissues.ITEM_BC, ""),
    Concat('Link to title')
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
        issues.itemnumber
      FROM
        issues
        LEFT JOIN items ON issues.itemnumber = items.itemnumber
      WHERE
        issues.note IS NOT NULL
      UNION
      SELECT
        old_issues.note,
        old_issues.borrowernumber,
        old_issues.notedate,
        items.barcode AS ITEM_BC,
        If(old_issues.itemnumber &lt;&gt; 0, "Item has already been returned",
        "Still checked out") AS IN_OR_OUT,
        old_issues.branchcode,
        old_issues.issuedate,
        old_issues.itemnumber
      FROM
        old_issues
        LEFT JOIN items ON old_issues.itemnumber = items.itemnumber
      WHERE
        old_issues.note IS NOT NULL) AS allissues
  JOIN borrowers ON allissues.borrowernumber = borrowers.borrowernumber
  LEFT JOIN items ON allissues.itemnumber = items.itemnumber
  INNER JOIN biblio ON items.biblionumber = biblio.biblionumber
WHERE
  items.barcode LIKE &lt;&gt;
GROUP BY
  allissues.borrowernumber,
  items.itemnumber
ORDER BY
  allissues.notedate DESC

























