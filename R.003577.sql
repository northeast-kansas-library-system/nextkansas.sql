/*
R.003577

----------

Name: LibraryIQ - Patron Data File (full) - BONNERSPGS 
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-05 23:55:10
Modified on: 2021-10-13 11:20:44
Date last run: 2021-11-07 00:40:02

----------

Public: 0
Expiry: 300

----------

#libraryiq #item #full #bonnerspgs #monthly

----------
*/



SELECT
  borrowers.borrowernumber AS UserID,
  borrowers.dateexpiry AS ExpirationDate,
  borrowers.branchcode AS `Patron Branch`,
  If(borrowers.debarred IS NOT NULL, "Restricted", "") AS Status,
  cko_count_ty.COUNT AS YTDYearCount,
  cko_count_py.COUNT AS PreviousYearCount,
  Concat("NA") AS LifetimeCount,
  Concat("NA") AS LastActivityDate,
  last_checkout.Min_datetime AS LastCheckoutDate,
  borrowers.dateenrolled AS RegistrationDate,
  borrowers.address AS StreetOne,
  borrowers.address2 AS AddressLn2,
  borrowers.city AS AddressCity,
  borrowers.state AS AddressState,
  borrowers.zipcode AS AddressZip,
  CurDate() AS `Report Date`
FROM
  borrowers LEFT JOIN
  (SELECT
     statistics.borrowernumber,
     count(*) AS COUNT
   FROM
     statistics
   WHERE
     statistics.datetime > CurDate() - INTERVAL 1 YEAR
   GROUP BY
     statistics.borrowernumber) cko_count_ty ON cko_count_ty.borrowernumber =
      borrowers.borrowernumber LEFT JOIN
  (SELECT
     statistics.borrowernumber,
     count(*) AS COUNT
   FROM
     statistics
   WHERE
     statistics.datetime BETWEEN CurDate() - INTERVAL 2 YEAR AND CurDate() -
     INTERVAL 1 YEAR
   GROUP BY
     statistics.borrowernumber) cko_count_py ON cko_count_py.borrowernumber =
      borrowers.borrowernumber LEFT JOIN
  (SELECT
     statistics.borrowernumber,
     Min(statistics.datetime) AS Min_datetime
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew')
   GROUP BY
     statistics.borrowernumber) last_checkout ON last_checkout.borrowernumber =
      borrowers.borrowernumber
WHERE
  borrowers.branchcode = 'BONNERSPGS'
GROUP BY
  borrowers.borrowernumber

























