/*
R.003592

----------

Name: LibraryIQ - Patron Data File (added yesterday) - BONNERSPGS 
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-13 10:44:37
Modified on: 2021-10-13 11:16:43
Date last run: 2021-11-08 00:30:02

----------

Public: 0
Expiry: 300

----------

#libraryiq #item #full #bonnerspgs #daily

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
      statistics.datetime BETWEEN CurDate() - INTERVAL 2 YEAR AND CurDate() - INTERVAL 1 YEAR
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
  borrowers.branchcode = 'BONNERSPGS' AND 
  Year(borrowers.dateenrolled) = Year(Now() - interval 1 day) AND
  Month(borrowers.dateenrolled) = Month(Now() - interval 1 day) AND
  Day(borrowers.dateenrolled) = Day(Now() - interval 1 day)
GROUP BY
  borrowers.borrowernumber

























