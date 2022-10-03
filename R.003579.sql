/*
R.003579

----------

Name: LibraryIQ - Circulation File (yesterday) - BONNERSPGS
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-11 10:38:17
Modified on: 2021-11-12 11:59:33
Date last run: 2022-04-20 00:05:03

----------

Public: 0
Expiry: 300

----------

#libraryiq #circulation #added #bonnerspgs #daily

----------
*/



SELECT
  issues.itemnumber AS RecordID,
  items.barcode AS Barcode,
  items.biblionumber AS BibRecordID,
  issues.issuedate AS `Checkout Date`,
  issues.branchcode AS `Check Out Branch`,
  issues.borrowernumber AS UserID,
  issues.date_due AS `Due Date`,
  CurDate() AS `Report Date`
FROM
  issues JOIN
  items ON issues.itemnumber = items.itemnumber
WHERE
  issues.branchcode = 'BONNERSPGS' AND
  Year(issues.issuedate) = Year(Now() - INTERVAL 1 DAY) AND
  Month(issues.issuedate) = Month(Now() - INTERVAL 1 DAY) AND
  Day(issues.issuedate) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  issues.issue_id
UNION
SELECT
  old_issues.itemnumber AS RecordID,
  Coalesce(items.barcode, deleteditems.barcode) AS Barcode,
  Coalesce(items.biblionumber, deleteditems.biblionumber) AS BibRecordID,
  old_issues.issuedate AS `Checkout Date`,
  old_issues.branchcode AS `Check Out Branch`,
  old_issues.borrowernumber AS UserID,
  old_issues.date_due AS `Due Date`,
  Concat('-') AS `Report Date`
FROM
  old_issues LEFT JOIN
  items ON old_issues.itemnumber = items.itemnumber LEFT JOIN
  deleteditems ON deleteditems.itemnumber = old_issues.itemnumber
WHERE
  old_issues.branchcode = 'BONNERSPGS' AND
  Year(old_issues.issuedate) = Year(Now() - INTERVAL 1 DAY) AND
  Month(old_issues.issuedate) = Month(Now() - INTERVAL 1 DAY) AND
  Day(old_issues.issuedate) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  old_issues.issue_id

























