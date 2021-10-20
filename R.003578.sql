/*
R.003578

----------

Name: LibraryIQ - Holds File (full) - BONNERSPGS 
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-05 23:56:43
Modified on: 2021-10-13 11:20:24
Date last run: 2021-10-13 11:28:16

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
  reserves.branchcode = 'BONNERSPGS'
GROUP BY
  reserves.biblionumber,
  reserves.branchcode,
  rcounts.Count_reserve_id

























