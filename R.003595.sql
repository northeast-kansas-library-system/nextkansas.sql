/*
R.003595

----------

Name: LibraryIQ - Holds File (cancelled/deleted/filled/expired yesterday) - BONNERSPGS
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-13 11:04:17
Modified on: 2021-11-12 12:01:10
Date last run: 2021-12-09 11:24:56

----------

Public: 0
Expiry: 300

----------

#libraryiq #item #deleted #bonnerspgs #daily

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
  old_reserves.branchcode = 'BONNERSPGS' AND
  Year(old_reserves.timestamp) = Year(Now() - INTERVAL 1 DAY) AND
  Month(old_reserves.timestamp) = Month(Now() - INTERVAL 1 DAY) AND
  Day(old_reserves.timestamp) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  old_reserves.biblionumber,
  old_reserves.branchcode,
  rcounts.Count_reserve_id

























