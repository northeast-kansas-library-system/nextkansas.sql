/*
R.002829

----------

Name: GHW - OD Letter Report - Phase 1
Created by: George Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-11-21 12:10:10
Modified on: 2016-11-21 13:23:30
Date last run: 2023-11-07 11:00:29

----------

Public: 0
Expiry: 0

----------

Getting item information so far

----------
*/



SELECT
  issues.borrowernumber,
  Concat_Ws('', (Concat_Ws(' / ', 'Call#-Author-Title', items.itemcallnumber, biblio.author, '',biblio.title,'')),
  (Concat_Ws(' / ', (Concat(DateDiff(Now(), issues.date_due), ' days overdue')), (Concat('Date due: ', CAST(issues.date_due AS date))), (Concat('Replacement price: ', CONCAT('$',FORMAT(items.replacementprice,2)) )))),
  (Concat_Ws(' / ', (Concat('Checked out at: ', issues.branchcode)), (Concat('Item home branch: ', items.homebranch)), (Concat('Barcode: ', items.barcode))))) AS BIGINFO
FROM
  items INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber INNER JOIN
  issues
    ON issues.itemnumber = items.itemnumber
WHERE
  issues.date_due < Now() - INTERVAL 7 DAY
GROUP BY
  issues.borrowernumber, issues.date_due
ORDER BY
  issues.borrowernumber

























