/*
R.003617

----------

Name: LibraryIQ - Holds File (added yesterday) - BASEHOR
Created by: George H Williams

----------

Group: LibraryIQ
     BASEHOR

Created on: 2021-11-08 11:26:22
Modified on: 2021-11-12 10:44:44
Date last run: 2022-04-20 00:20:02

----------

Public: 0
Expiry: 300

----------

#libraryiq #requests #added #basehor #daily

----------
*/



SELECT
  reserves.biblionumber AS BibRecordID,
  reserves.branchcode AS Branch,
  rcounts.Count_reserve_id AS `Number of Requests`,
  CurDate() AS `Report Date`
FROM
  reserves LEFT JOIN
  (SELECT
      reserves.biblionumber,
      Count(reserves.reserve_id) AS Count_reserve_id
    FROM
      reserves
    GROUP BY
      reserves.biblionumber) rcounts ON rcounts.biblionumber =
      reserves.biblionumber
WHERE
  reserves.branchcode = 'BASEHOR' AND
  Year(reserves.reservedate) = Year(Now() - INTERVAL 1 DAY) AND
  Month(reserves.reservedate) = Month(Now() - INTERVAL 1 DAY) AND
  Day(reserves.reservedate) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  reserves.biblionumber,
  reserves.branchcode,
  rcounts.Count_reserve_id

























