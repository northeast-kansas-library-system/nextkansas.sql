/*
R.003587

----------

Name: LibraryIQ - Circulation File (based on statistics table - last 2 years) (setup)
Created by: George H Williams

----------

Group: LibraryIQ
     Setup

Created on: 2021-10-12 22:21:50
Modified on: 2021-10-13 11:13:52
Date last run: 2021-10-13 11:21:50

----------

Public: 0
Expiry: 300

----------

#libraryiq #setup 

----------
*/



SELECT
  statistics.itemnumber AS RecordID,
  Coalesce(items.barcode, deleteditems.barcode) AS Barcode,
  items.biblionumber AS BibRecordID,
  statistics.datetime AS `Checkout Date`,
  statistics.branch AS `Check Out Branch`,
  statistics.borrowernumber AS UserID,
  CurDate() AS `Report Date`
FROM
  statistics LEFT JOIN
  items ON items.itemnumber = statistics.itemnumber LEFT JOIN
  deleteditems ON deleteditems.itemnumber = statistics.itemnumber
WHERE
  statistics.branch = <<Choose your library|branches>> AND
  (statistics.type = 'issue' OR
      statistics.type = 'renew') AND
  statistics.datetime > CurDate() - INTERVAL 2 YEAR

























