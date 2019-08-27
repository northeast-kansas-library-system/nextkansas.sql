/*
R.002830

----------

Name: Phase 2 Concat w group
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-11-21 13:26:03
Modified on: 2016-11-21 18:42:09
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  Concat_Ws('<br />', CONCAT('<ins>',(Concat_Ws(' | ', 'Item details: ', items.itemcallnumber, biblio.author, CONCAT('<span style="text-transform: uppercase">', biblio.title,'</span>'), concat(items.barcode,'</ins>')))),
  (Concat_Ws(' | ',(Concat(DateDiff(Now(), issues.date_due), ' days overdue')), (Concat('Date due: ', CAST(issues.date_due AS date))), (Concat('Replacement price: $', items.replacementprice)))), 
  (Concat_Ws(' | ',(Concat('Checked out at: ', issues.branchcode)), CONCAT( (Concat('Item home branch: ',items.homebranch)),'<br /><p> </p>')))) AS ITEMINFO,
  items.content
FROM
  items JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  issues
    ON issues.itemnumber = items.itemnumber
WHERE
  issues.date_due < Now() - INTERVAL 7 DAY AND issues.borrowernumber LIKE <<Enter borrower number>> AND issues.branchcode LIKE <<Checkout branch|LBRANCH>>
GROUP BY
  issues.borrowernumber, items.itemnumber
ORDER BY
  issues.borrowernumber ASC




