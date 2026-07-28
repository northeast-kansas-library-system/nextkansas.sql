/*
R.002733

----------

Name: GHW - Expiration Query
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2016-08-12 18:20:41
Modified on: 2024-02-19 16:56:06
Date last run: 2026-06-11 09:40:16

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT 
  YEAR(borrowers.dateexpiry) AS EXPIRATION_YEAR, 
  Count(DISTINCT borrowers.borrowernumber) AS BORROWER_COUNT 
FROM borrowers 
GROUP BY 
  YEAR(borrowers.dateexpiry) 
ORDER BY 
  YEAR(borrowers.dateexpiry) DESC

























