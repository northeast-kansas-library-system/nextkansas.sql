/*
R.002867

----------

Name: GHW - YE - 9.1a
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly Stats Suite

Created on: 2017-01-01 22:39:19
Modified on: 2020-01-01 14:18:44
Date last run: 2020-01-01 14:19:18

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchcode,
  Coalesce(Count(BOOK_S.itemnumber), 0) AS '9.1a_BOOK_S'
FROM
  branches LEFT JOIN
  (SELECT
    items.homebranch,
    items.itemnumber
  FROM
    items
  WHERE
    items.dateaccessioned < MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR AND
    ((items.itype IN ('book', 'localhold2', 'newbook', 'walkin2')) OR
      (items.itype = 'localhold' AND
        items.ccode IN ('easy', 'fiction', 'nonfiction', 'profcoll')) OR
      (items.itype = 'reference' AND
        items.ccode NOT IN ('bookoncd', 'bookonmp', 'computer', 'GADGET',
        'GAMECUBE', 'magazine', 'MAP', 'SOFTWARE', 'vhs', 'dvd', 'misc',
        'blu-ray')) OR
      (items.itype = 'walkin' AND
        items.ccode IN ('biography', 'easy', 'holiday', 'kansas', 'genealogy',
        'nonfiction', 'profcoll', 'walkin')))
  GROUP BY
    items.homebranch, items.itemnumber
  UNION
  SELECT
    deleteditems.homebranch,
    deleteditems.itemnumber
  FROM
    deleteditems
  WHERE
    deleteditems.dateaccessioned < MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR
    AND
    ((deleteditems.itype IN ('book', 'localhold2', 'newbook', 'walkin2')) OR
      (deleteditems.itype = 'localhold' AND
        deleteditems.ccode IN ('easy', 'fiction', 'nonfiction', 'profcoll')) OR
      (deleteditems.itype = 'reference' AND
        deleteditems.ccode NOT IN ('bookoncd', 'bookonmp', 'computer', 'GADGET',
        'GAMECUBE', 'magazine', 'MAP', 'SOFTWARE', 'vhs', 'dvd', 'misc',
        'blu-ray')) OR
      (deleteditems.itype = 'walkin' AND
        deleteditems.ccode IN ('biography', 'easy', 'holiday', 'kansas',
        'genealogy', 'nonfiction', 'profcoll', 'walkin'))) AND
    deleteditems.timestamp BETWEEN (MakeDate(Year(Now()), 1) - INTERVAL 1
    YEAR) AND (MakeDate(Year(Now()), 1))
  GROUP BY
    deleteditems.homebranch, deleteditems.itemnumber) BOOK_S
    ON branches.branchcode = BOOK_S.homebranch
GROUP BY
  branches.branchcode




