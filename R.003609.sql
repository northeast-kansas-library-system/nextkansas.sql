/*
R.003609

----------

Name: LibraryIQ - Holds File (full) - BASEHOR
Created by: George H Williams

----------

Group: LibraryIQ
     BASEHOR

Created on: 2021-11-08 10:58:20
Modified on: 2021-11-12 11:49:36
Date last run: 2021-11-16 18:29:15

----------

Public: 0
Expiry: 300

----------

#libraryiq #requests #full #basehor #weekly


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
  reserves.branchcode = 'BASEHOR'
GROUP BY
  reserves.biblionumber,
  reserves.branchcode,
  rcounts.Count_reserve_id

























