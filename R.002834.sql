/*
R.002834

----------

Name: 002 - Monthly circulation by borrower's category
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-11-28 08:46:28
Modified on: 2016-11-28 12:20:44
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  statistics.branch,
  If(borrowers.categorycode IS NULL AND deletedborrowers.categorycode IS NULL,
  ' --', Concat(Coalesce(borrowers.categorycode, deletedborrowers.categorycode)))
  AS PATRON_CATEGORY,
  Count(*) AS CIRC_PLUS_RENEWALS,
  Concat_Ws('.', Year(statistics.datetime), Month(statistics.datetime)) AS DATE
FROM
  statistics LEFT JOIN
  borrowers
    ON statistics.borrowernumber = borrowers.borrowernumber LEFT JOIN
  deletedborrowers
    ON statistics.borrowernumber = deletedborrowers.borrowernumber
WHERE
  (statistics.type = 'issue' OR statistics.type = 'renew' OR statistics.type = 'localuse') AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
GROUP BY
  statistics.branch,
  PATRON_CATEGORY
  WITH ROLLUP



