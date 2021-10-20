/*
R.002840

----------

Name: GHW - 999 Checkouts super master
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-11-28 12:50:21
Modified on: 2016-11-28 12:50:21
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  statistics.branch AS CHECKOUT_BRANCH,
  If(borrowers.branchcode IS NULL AND deletedborrowers.branchcode IS NULL, ' --', Concat(Coalesce(borrowers.branchcode, deletedborrowers.branchcode))) AS BORROWERS_HOMEBRANCH,
  If(borrowers.categorycode IS NULL AND deletedborrowers.categorycode IS NULL, ' --', Concat(Coalesce(borrowers.categorycode, deletedborrowers.categorycode))) AS BORROWERS_CATEGORY,
  If(items.homebranch IS NULL AND deleteditems.homebranch IS NULL, ' --', Concat(Coalesce(items.homebranch, deleteditems.homebranch))) AS ITEM_HOMEBRANCH,
  If(items.itype IS NULL AND deleteditems.itype IS NULL, ' --', Concat(Coalesce(items.itype, deleteditems.itype))) AS ITEM_TYPE,
  If(items.ccode IS NULL AND deleteditems.ccode IS NULL, ' --', Concat(Coalesce(items.ccode, deleteditems.ccode))) AS COLLECTION_CODE,
  Count(*) AS CIRC_PLUS_RENEWALS,
  Concat_Ws('-', Year(statistics.datetime), Month(statistics.datetime)) AS `YEAR_MONTH`
FROM
  statistics LEFT JOIN
  borrowers
    ON statistics.borrowernumber = borrowers.borrowernumber LEFT JOIN
  deletedborrowers
    ON statistics.borrowernumber = deletedborrowers.borrowernumber LEFT JOIN
  items
    ON statistics.itemnumber = items.itemnumber LEFT JOIN
  deleteditems
    ON statistics.itemnumber = deleteditems.itemnumber
WHERE
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
  (statistics.type = 'issue' OR statistics.type = 'renew' OR statistics.type = 'localuse') AND
  statistics.branch LIKE <<Check-out branch|LBRANCH>> AND
  If(borrowers.branchcode IS NULL AND deletedborrowers.branchcode IS NULL, ' --', Concat(Coalesce(borrowers.branchcode, deletedborrowers.branchcode))) LIKE <<Borrower's home branch|LBRANCH>>AND
  If(borrowers.categorycode IS NULL AND deletedborrowers.categorycode IS NULL, ' --', Concat(Coalesce(borrowers.categorycode, deletedborrowers.categorycode))) LIKE <<Borrower's category|categorycode>> AND
  If(items.homebranch IS NULL AND deleteditems.homebranch IS NULL, ' --', Concat(Coalesce(items.homebranch, deleteditems.homebranch))) LIKE <<Item home branch|LBRANCH>> AND
  If(items.itype IS NULL AND deleteditems.itype IS NULL, ' --', Concat(Coalesce(items.itype, deleteditems.itype))) LIKE  AND
  If(items.ccode IS NULL AND deleteditems.ccode IS NULL, ' --', Concat(Coalesce(items.ccode, deleteditems.ccode))) LIKE '%'
GROUP BY
  CHECKOUT_BRANCH,
  BORROWERS_HOMEBRANCH,
  BORROWERS_CATEGORY,
  ITEM_HOMEBRANCH,
  ITEM_TYPE,
  COLLECTION_CODE
  WITH ROLLUP

























