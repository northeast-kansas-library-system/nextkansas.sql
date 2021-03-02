/*
R.002867

----------

Name: GHW - YE - 9.1a
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly Stats Suite

Created on: 2017-01-01 22:39:19
Modified on: 2020-12-31 14:59:17
Date last run: 2021-01-01 11:18:16

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
      ((items.itype = 'BOOK' OR
              items.itype = 'LOCALHOLD2' OR
              items.itype = 'PBBKNEW' OR
              items.itype = 'WALKIN2') OR
          (items.itype = 'LOCALHOLD' AND
              items.ccode = 'BOARDBK' OR
              items.ccode = 'EASY' OR
              items.ccode = 'FICTION' OR
              items.ccode = 'GRAPHIC' OR
              items.ccode = 'NONFICTION' OR
              items.ccode = 'OVERSIZE' OR
              items.ccode = 'PARENTING' OR
              items.ccode = 'READER' OR
              items.ccode = 'WESTERN') OR
          (items.itype = 'REFERENCE' AND
              items.ccode = 'ATLAS' OR
              items.ccode = 'BINDER' OR
              items.ccode = 'BIOGRAPHY' OR
              items.ccode = 'EASY' OR
              items.ccode = 'FICTION' OR
              items.ccode = 'GENEALOGY' OR
              items.ccode = 'GRAPHIC' OR
              items.ccode = 'INSPRATION' OR
              items.ccode = 'KANSAS' OR
              items.ccode = 'NONFICTION' OR
              items.ccode = 'OVERSIZE' OR
              items.ccode = 'PROFCOLL' OR
              items.ccode = 'REFERENCE') OR
          (items.itype = 'WALKIN' AND
              items.ccode = 'BIOGRAPHY' OR
              items.ccode = 'BOARDBK' OR
              items.ccode = 'EASY' OR
              items.ccode = 'FICTION' OR
              items.ccode = 'GENEALOGY' OR
              items.ccode = 'HOLIDAY' OR
              items.ccode = 'KANSAS' OR
              items.ccode = 'MYSTERY' OR
              items.ccode = 'NONFICTION' OR
              items.ccode = 'OVERSIZE' OR
              items.ccode = 'PAPERBACK' OR
              items.ccode = 'PARENTING' OR
              items.ccode = 'PROFCOLL' OR
              items.ccode = 'REFERENCE' OR
              items.ccode = 'SF-FANT'))
    GROUP BY
      items.homebranch,
      items.itemnumber
    UNION
    SELECT
      deleteditems.homebranch,
      deleteditems.itemnumber
    FROM
      deleteditems
    WHERE
      deleteditems.dateaccessioned < MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR
      AND
      ((deleteditems.itype = 'BOOK' OR
              deleteditems.itype = 'LOCALHOLD2' OR
              deleteditems.itype = 'PBBKNEW' OR
              deleteditems.itype = 'WALKIN2') OR
          (deleteditems.itype = 'LOCALHOLD' AND
              deleteditems.ccode = 'BOARDBK' OR
              deleteditems.ccode = 'EASY' OR
              deleteditems.ccode = 'FICTION' OR
              deleteditems.ccode = 'GRAPHIC' OR
              deleteditems.ccode = 'NONFICTION' OR
              deleteditems.ccode = 'OVERSIZE' OR
              deleteditems.ccode = 'PARENTING' OR
              deleteditems.ccode = 'READER' OR
              deleteditems.ccode = 'WESTERN') OR
          (deleteditems.itype = 'REFERENCE' AND
              deleteditems.ccode = 'ATLAS' OR
              deleteditems.ccode = 'BINDER' OR
              deleteditems.ccode = 'BIOGRAPHY' OR
              deleteditems.ccode = 'EASY' OR
              deleteditems.ccode = 'FICTION' OR
              deleteditems.ccode = 'GENEALOGY' OR
              deleteditems.ccode = 'GRAPHIC' OR
              deleteditems.ccode = 'INSPRATION' OR
              deleteditems.ccode = 'KANSAS' OR
              deleteditems.ccode = 'NONFICTION' OR
              deleteditems.ccode = 'OVERSIZE' OR
              deleteditems.ccode = 'PROFCOLL' OR
              deleteditems.ccode = 'REFERENCE') OR
          (deleteditems.itype = 'WALKIN' AND
              deleteditems.ccode = 'BIOGRAPHY' OR
              deleteditems.ccode = 'BOARDBK' OR
              deleteditems.ccode = 'EASY' OR
              deleteditems.ccode = 'FICTION' OR
              deleteditems.ccode = 'GENEALOGY' OR
              deleteditems.ccode = 'HOLIDAY' OR
              deleteditems.ccode = 'KANSAS' OR
              deleteditems.ccode = 'MYSTERY' OR
              deleteditems.ccode = 'NONFICTION' OR
              deleteditems.ccode = 'OVERSIZE' OR
              deleteditems.ccode = 'PAPERBACK' OR
              deleteditems.ccode = 'PARENTING' OR
              deleteditems.ccode = 'PROFCOLL' OR
              deleteditems.ccode = 'REFERENCE' OR
              deleteditems.ccode = 'SF-FANT')) AND
      deleteditems.timestamp BETWEEN (MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR) AND (MakeDate(Year(Now()), 1))
    GROUP BY
      deleteditems.homebranch,
      deleteditems.itemnumber) BOOK_S ON branches.branchcode = BOOK_S.homebranch
GROUP BY
  branches.branchcode



