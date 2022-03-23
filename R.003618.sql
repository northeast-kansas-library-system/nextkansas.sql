/*
R.003618

----------

Name: LibraryIQ - Holds File (cancelled/deleted/filled/expired yesterday) - BASEHOR
Created by: George H Williams

----------

Group: LibraryIQ
     BASEHOR

Created on: 2021-11-08 11:29:00
Modified on: 2021-11-08 11:29:00
Date last run: 2022-03-23 00:25:02

----------

Public: 0
Expiry: 300

----------

#libraryiq #requests #deleted #basehor #daily

----------
*/



SELECT
  old_reserves.biblionumber AS BibRecordID,
  old_reserves.branchcode AS Branch,
  rcounts.Count_reserve_id AS `Number of Requests`,
  CurDate() AS `Report Date`
FROM
  old_reserves LEFT JOIN
  (SELECT
      old_reserves.biblionumber,
      Count(old_reserves.reserve_id) AS Count_reserve_id
    FROM
      old_reserves
    GROUP BY
      old_reserves.biblionumber) rcounts ON rcounts.biblionumber =
      old_reserves.biblionumber
WHERE
  old_reserves.branchcode = 'BASEHOR' AND
  Year(old_reserves.timestamp) = Year(Now() - INTERVAL 1 DAY) AND
  Month(old_reserves.timestamp) = Month(Now() - INTERVAL 1 DAY) AND
  Day(old_reserves.timestamp) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  old_reserves.biblionumber,
  old_reserves.branchcode,
  rcounts.Count_reserve_id

























