/*
R.003482

----------

Name: GHW - Phantom restrictions ADMINREPORT
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2021-03-10 14:54:38
Modified on: 2024-01-17 12:00:49
Date last run: 2022-04-04 13:56:38

----------

Public: 0
Expiry: 300

----------

 
Searches for phantom restrictions
Searches for current instances where data exists in borrowers.debarred but there is no corresponding entry in borrower_debarments.
grouped and sorted by borrowernumber

Notes:

Run once a week to identify borrowers with phantom restrictions.  Then use the batch patron editor to remove all restrictions from the accounts.

Training on this report

Click here to run in a new window
borrowers restrictions


----------
*/



SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.debarred,
  borrowers.debarredcomment,
  borrower_debarments.borrower_debarment_id
FROM
  borrowers LEFT JOIN
  borrower_debarments ON borrower_debarments.borrowernumber =
      borrowers.borrowernumber
WHERE
  borrowers.debarred IS NOT NULL AND
  borrower_debarments.borrower_debarment_id IS NULL
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.borrowernumber

























