/*
R.003594

----------

Name: LibraryIQ - Holds File (added yesterday) - BONNERSPGS 
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-13 10:59:59
Modified on: 2021-10-13 11:19:18
Date last run: 2021-11-01 09:13:21

----------

Public: 0
Expiry: 300

----------

#libraryiq #item #full #bonnerspgs #monthly

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
  reserves.branchcode = 'BONNERSPGS' AND
  Year(reserves.reservedate) = Year(Now() - INTERVAL 1 DAY) AND
  Month(reserves.reservedate) = Month(Now() - INTERVAL 1 DAY) AND
  Day(reserves.reservedate) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  reserves.biblionumber,
  reserves.branchcode,
  rcounts.Count_reserve_id

























