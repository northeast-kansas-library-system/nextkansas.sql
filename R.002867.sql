/*
R.002867

----------

Name: GHW - YE - 9.1a
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly Stats Suite

Created on: 2017-01-01 22:39:19
Modified on: 2021-12-30 22:38:38
Date last run: 2022-01-01 01:32:02

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
  (
    SELECT
      items.homebranch,
      items.itemnumber
    FROM
      items
    WHERE
      items.dateaccessioned < MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR AND
      ((items.itype = 'BOOK' OR
        items.itype = 'PBBKNEW' OR
        items.itype = 'PBBKCLUB' OR
        items.itype = 'PBBKWALK' OR
        items.itype = 'LOCALHOLD2') OR
      (items.itype = 'PUNC' AND
        (items.ccode = 'XXX' OR
        items.ccode = 'BIOGRAPHY' OR
        items.ccode = 'BOARDBK' OR
        items.ccode = 'JYA_CHAP' OR
        items.ccode = 'READER' OR
        items.ccode = 'FICTION' OR
        items.ccode = 'GENEALOGY' OR
        items.ccode = 'INSPRATION' OR
        items.ccode = 'KANSAS' OR
        items.ccode = 'LARGEPRINT' OR
        items.ccode = 'MYSTERY' OR
        items.ccode = 'NONFICTION' OR
        items.ccode = 'PAPERBACK' OR
        items.ccode = 'EASY' OR
        items.ccode = 'REFERENCE' OR
        items.ccode = 'ROMANCE' OR
        items.ccode = 'SF-FANT')) OR
      (items.itype = 'LOCALHOLD' AND
        (items.ccode = 'XXX' OR
        items.ccode = 'BIOGRAPHY' OR
        items.ccode = 'BOARDBK' OR
        items.ccode = 'READER' OR
        items.ccode = 'EDUCATION' OR
        items.ccode = 'FICTION' OR
        items.ccode = 'GRAPHIC' OR
        items.ccode = 'KANSAS' OR
        items.ccode = 'NONFICTION' OR
        items.ccode = 'OVERSIZE' OR
        items.ccode = 'PARENTING' OR
        items.ccode = 'EASY' OR
        items.ccode = 'PROFCOLL' OR
        items.ccode = 'WESTERN')) OR
      (items.itype = 'REFERENCE' AND
        (items.ccode = 'ATLAS' OR
        items.ccode = 'BIOGRAPHY' OR
        items.ccode = 'FICTION' OR
        items.ccode = 'GENEALOGY' OR
        items.ccode = 'GRAPHIC' OR
        items.ccode = 'INSPRATION' OR
        items.ccode = 'KANSAS' OR
        items.ccode = 'NONFICTION' OR
        items.ccode = 'OVERSIZE' OR
        items.ccode = 'EASY' OR
        items.ccode = 'PROFCOLL' OR
        items.ccode = 'REFERENCE')) OR
      (items.itype = 'PSPECIAL' AND
        (items.ccode = 'XXX' OR
        items.ccode = 'BIOGRAPHY' OR
        items.ccode = 'BOARDBK' OR
        items.ccode = 'EDUCATION' OR
        items.ccode = 'FICTION' OR
        items.ccode = 'GENEALOGY' OR
        items.ccode = 'HOLIDAY' OR
        items.ccode = 'KANSAS' OR
        items.ccode = 'MYSTERY' OR
        items.ccode = 'NONFICTION' OR
        items.ccode = 'OVERSIZE' OR
        items.ccode = 'PAPERBACK' OR
        items.ccode = 'PARENTING' OR
        items.ccode = 'EASY' OR
        items.ccode = 'PROFCOLL' OR
        items.ccode = 'REFERENCE' OR
        items.ccode = 'SF-FANT' OR
        items.ccode = 'SPC_DARE')))
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
      deleteditems.itype = 'PBBKNEW' OR
      deleteditems.itype = 'PBBKWALK' OR
      deleteditems.itype = 'PBBKCLUB' OR 
      deleteditems.itype = 'LOCALHOLD2') OR
      (deleteditems.itype = 'PUNC' AND
        (deleteditems.ccode = 'XXX' OR
        deleteditems.ccode = 'BIOGRAPHY' OR
        deleteditems.ccode = 'BOARDBK' OR
        deleteditems.ccode = 'JYA_CHAP' OR
        deleteditems.ccode = 'READER' OR
        deleteditems.ccode = 'FICTION' OR
        deleteditems.ccode = 'GENEALOGY' OR
        deleteditems.ccode = 'INSPRATION' OR
        deleteditems.ccode = 'KANSAS' OR
        deleteditems.ccode = 'LARGEPRINT' OR
        deleteditems.ccode = 'MYSTERY' OR
        deleteditems.ccode = 'NONFICTION' OR
        deleteditems.ccode = 'PAPERBACK' OR
        deleteditems.ccode = 'EASY' OR
        deleteditems.ccode = 'REFERENCE' OR
        deleteditems.ccode = 'ROMANCE' OR
        deleteditems.ccode = 'SF-FANT')) OR
      (deleteditems.itype = 'LOCALHOLD' AND
        (deleteditems.ccode = 'XXX' OR
        deleteditems.ccode = 'BIOGRAPHY' OR
        deleteditems.ccode = 'BOARDBK' OR
        deleteditems.ccode = 'READER' OR
        deleteditems.ccode = 'EDUCATION' OR
        deleteditems.ccode = 'FICTION' OR
        deleteditems.ccode = 'GRAPHIC' OR
        deleteditems.ccode = 'KANSAS' OR
        deleteditems.ccode = 'NONFICTION' OR
        deleteditems.ccode = 'OVERSIZE' OR
        deleteditems.ccode = 'PARENTING' OR
        deleteditems.ccode = 'EASY' OR
        deleteditems.ccode = 'PROFCOLL' OR
        deleteditems.ccode = 'WESTERN')) OR
      (deleteditems.itype = 'REFERENCE' AND
        (deleteditems.ccode = 'ATLAS' OR
        deleteditems.ccode = 'BIOGRAPHY' OR
        deleteditems.ccode = 'FICTION' OR
        deleteditems.ccode = 'GENEALOGY' OR
        deleteditems.ccode = 'GRAPHIC' OR
        deleteditems.ccode = 'INSPRATION' OR
        deleteditems.ccode = 'KANSAS' OR
        deleteditems.ccode = 'NONFICTION' OR
        deleteditems.ccode = 'OVERSIZE' OR
        deleteditems.ccode = 'EASY' OR
        deleteditems.ccode = 'PROFCOLL' OR
        deleteditems.ccode = 'REFERENCE')) OR
      (deleteditems.itype = 'PSPECIAL' AND
        (deleteditems.ccode = 'XXX' OR
        deleteditems.ccode = 'BIOGRAPHY' OR
        deleteditems.ccode = 'BOARDBK' OR
        deleteditems.ccode = 'EDUCATION' OR
        deleteditems.ccode = 'FICTION' OR
        deleteditems.ccode = 'GENEALOGY' OR
        deleteditems.ccode = 'HOLIDAY' OR
        deleteditems.ccode = 'KANSAS' OR
        deleteditems.ccode = 'MYSTERY' OR
        deleteditems.ccode = 'NONFICTION' OR
        deleteditems.ccode = 'OVERSIZE' OR
        deleteditems.ccode = 'PAPERBACK' OR
        deleteditems.ccode = 'PARENTING' OR
        deleteditems.ccode = 'EASY' OR
        deleteditems.ccode = 'PROFCOLL' OR
        deleteditems.ccode = 'REFERENCE' OR
        deleteditems.ccode = 'SF-FANT' OR
        deleteditems.ccode = 'SPC_DARE'))
    ) AND
    deleteditems.timestamp BETWEEN (MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR) AND (MakeDate(Year(Now()), 1))
  GROUP BY
    deleteditems.homebranch,
    deleteditems.itemnumber) BOOK_S ON branches.branchcode = BOOK_S.homebranch
GROUP BY
  branches.branchcode

























