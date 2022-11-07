/*
R.003018

----------

Name: GHW - YEAREND 1801
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly Stats Suite

Created on: 2017-12-19 16:03:27
Modified on: 2017-12-19 16:03:51
Date last run: 2022-10-19 08:40:11

----------

Public: 0
Expiry: 300

----------

Biblios and items - run at 12:05 a.m. on January 1

----------
*/



SELECT
  branches.branchcode,
  Coalesce(CURRENT_BIBLIO_COUNT.Count_biblionumber, 0) AS BIBLIO_COUNT,
  Coalesce(CURRENT_ITEM_COUNT.Count_itemnumber, 0) AS ITEM_COUNT
FROM
  branches
  LEFT JOIN (SELECT
        items.homebranch,
        Count(DISTINCT items.itemnumber) AS Count_itemnumber
      FROM
        items
      GROUP BY
        items.homebranch) CURRENT_ITEM_COUNT ON branches.branchcode = CURRENT_ITEM_COUNT.homebranch
  LEFT JOIN (SELECT
        items.homebranch,
        Count(DISTINCT items.biblionumber) AS Count_biblionumber
      FROM
        items
      GROUP BY
        items.homebranch) CURRENT_BIBLIO_COUNT ON branches.branchcode = CURRENT_BIBLIO_COUNT.homebranch

























