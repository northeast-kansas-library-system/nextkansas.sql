/*
R.002829

----------

Name: GHW - OD Letter Report - Phase 1
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-11-21 12:10:10
Modified on: 2016-11-21 13:23:30
Date last run: 2017-11-22 13:38:33

----------

Public: 0
Expiry: 0

----------

Getting item information so far

----------
*/

SELECT
  issues.borrowernumber,
  Concat_Ws('<br />', (Concat_Ws(' / ', '<ins>Call#-Author-Title</ins>', items.itemcallnumber, biblio.author, '<span style="text-transform: uppercase">',biblio.title,'</span>')),
  (Concat_Ws(' / ', (Concat(DateDiff(Now(), issues.date_due), ' <ins>days overdue</ins>')), (Concat('<ins>Date due:</ins> ', CAST(issues.date_due AS date))), (Concat('<ins>Replacement price:</ins> ', CONCAT('$',FORMAT(items.replacementprice,2)) )))),
  (Concat_Ws(' / ', (Concat('<ins>Checked out at:</ins> ', issues.branchcode)), (Concat('<ins>Item home branch:</ins> ', items.homebranch)), (Concat('Barcode: ', items.barcode))))) AS BIGINFO
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



