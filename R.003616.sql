/*
R.003616

----------

Name: LibraryIQ - Patron Data File (deleted yesterday) - BASEHOR
Created by: George H Williams

----------

Group: LibraryIQ
     BASEHOR

Created on: 2021-11-08 11:24:37
Modified on: 2021-11-08 11:24:37
Date last run: 2022-03-23 00:45:04

----------

Public: 0
Expiry: 300

----------

#libraryiq #borrowers #deleted #basehor #daily

----------
*/



SELECT
  deletedborrowers.borrowernumber AS UserID,
  deletedborrowers.dateexpiry AS ExpirationDate,
  deletedborrowers.branchcode AS `Patron Branch`,
  If(deletedborrowers.debarred IS NOT NULL, "Restricted", "") AS Status,
  cko_count_ty.COUNT AS YTDYearCount,
  cko_count_py.COUNT AS PreviousYearCount,
  Concat("NA") AS LifetimeCount,
  Concat("NA") AS LastActivityDate,
  last_checkout.Min_datetime AS LastCheckoutDate,
  deletedborrowers.dateenrolled AS RegistrationDate,
  deletedborrowers.address AS StreetOne,
  deletedborrowers.address2 AS AddressLn2,
  deletedborrowers.city AS AddressCity,
  deletedborrowers.state AS AddressState,
  deletedborrowers.zipcode AS AddressZip,
  CurDate() AS `Report Date`
FROM
  deletedborrowers LEFT JOIN
  (SELECT
      statistics.borrowernumber,
      count(*) AS COUNT
    FROM
      statistics
    WHERE
      statistics.datetime > CurDate() - INTERVAL 1 YEAR
    GROUP BY
      statistics.borrowernumber) cko_count_ty ON cko_count_ty.borrowernumber =
      deletedborrowers.borrowernumber LEFT JOIN
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
      deletedborrowers.borrowernumber LEFT JOIN
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
      deletedborrowers.borrowernumber
WHERE
  deletedborrowers.branchcode = 'BASEHOR' AND
  Year(deletedborrowers.updated_on) = Year(Now() - INTERVAL 1 DAY) AND
  Month(deletedborrowers.updated_on) = Month(Now() - INTERVAL 1 DAY) AND
  Day(deletedborrowers.updated_on) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  deletedborrowers.borrowernumber

























