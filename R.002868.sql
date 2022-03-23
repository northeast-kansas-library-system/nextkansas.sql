/*
R.002868

----------

Name: GHW - YE 9.1b-9.5
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly Stats Suite

Created on: 2017-01-01 22:40:38
Modified on: 2021-12-31 13:44:20
Date last run: 2022-01-01 01:27:02

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches.branchcode AS BRANCH,
  Coalesce(Count(BOOKS_A.itemnumber), 0) AS '9.1b_BOOKS_A',
  Coalesce(BOOKS_D.COUNT, 0) AS '9.1c_BOOKS_D',
  Coalesce(AUDIO_T.COUNT, 0) AS '9.2_ADUTIO_T',
  Coalesce(VIDEO_T.COUNT, 0) AS '9.3a_VIDEO_T',
  Coalesce(VIDEO_DVD_T.COUNT, 0) AS '9.3b_VIDEO_DVD_T',
  Coalesce(ALL_ITEMS.COUNT, 0) - Coalesce(ALL_BOOKS.COUNT, 0) -
  Coalesce(AUDIO_T.COUNT, 0) - Coalesce(VIDEO_T.COUNT, 0) AS '9.5_OTHER_T'
FROM
  branches LEFT JOIN
  (SELECT
      items.homebranch,
      items.itemnumber
    FROM
      items
    WHERE
      (Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 YEAR) AND
        (items.itype = 'BOOK' OR
          items.itype = 'PBBKNEW' OR
          items.itype = 'PBBKCLUB' OR
          items.itype = 'PBBKWALK' OR
          items.itype = 'LOCALHOLD2') OR
        (Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 YEAR) AND
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
              items.ccode = 'SPC_DARE'))))
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
      (Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 YEAR) AND
        (deleteditems.itype = 'BOOK' OR
          deleteditems.itype = 'PBBKNEW' OR
          deleteditems.itype = 'PBBKWALK' OR
          deleteditems.itype = 'PBBKCLUB' OR
          deleteditems.itype = 'LOCALHOLD2')) OR
      (Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 YEAR) AND
        ((deleteditems.itype = 'PUNC' AND
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
              deleteditems.ccode = 'SPC_DARE'))))
    GROUP BY
      deleteditems.homebranch,
      deleteditems.itemnumber) BOOKS_A ON branches.branchcode =
      BOOKS_A.homebranch LEFT JOIN
  (SELECT
      deleteditems.homebranch,
      Count(deleteditems.itemnumber) AS COUNT
    FROM
      deleteditems
    WHERE
      (Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 YEAR) AND
        (deleteditems.itype = 'BOOK' OR
          deleteditems.itype = 'LOCALHOLD2' OR
          deleteditems.itype = 'PBBKNEW' OR
          deleteditems.itype = 'WALKIN2')) OR
      (Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 YEAR) AND
        (deleteditems.itype = 'LOCALHOLD' OR
          deleteditems.itype = 'REFERENCE' OR
          deleteditems.itype = 'WALKIN' OR
          deleteditems.itype = 'XXX') AND
        (deleteditems.ccode = 'BILINGUAL' OR
          deleteditems.ccode = 'BIOGRAPHY' OR
          deleteditems.ccode = 'BOARDBK' OR
          deleteditems.ccode = 'EASY' OR
          deleteditems.ccode = 'EDUCATION' OR
          deleteditems.ccode = 'FICTION' OR
          deleteditems.ccode = 'GENEALOGY' OR
          deleteditems.ccode = 'GRAPHIC' OR
          deleteditems.ccode = 'HOLIDAY' OR
          deleteditems.ccode = 'INSPRATION' OR
          deleteditems.ccode = 'KANSAS' OR
          deleteditems.ccode = 'LARGEPRINT' OR
          deleteditems.ccode = 'LARGEPRNF' OR
          deleteditems.ccode = 'MYSTERY' OR
          deleteditems.ccode = 'NONFICTION' OR
          deleteditems.ccode = 'OVERSIZE' OR
          deleteditems.ccode = 'PAPERBACK' OR
          deleteditems.ccode = 'PARENTING' OR
          deleteditems.ccode = 'PROFCOLL' OR
          deleteditems.ccode = 'READER' OR
          deleteditems.ccode = 'ROMANCE' OR
          deleteditems.ccode = 'SF-FANT' OR
          deleteditems.ccode = 'SPANISH' OR
          deleteditems.ccode = 'WESTERN'))
    GROUP BY
      deleteditems.homebranch) BOOKS_D ON branches.branchcode =
      BOOKS_D.homebranch LEFT JOIN
  (SELECT
      items.homebranch,
      COUNT(*) AS COUNT
    FROM
      items
    WHERE
      (Year(items.dateaccessioned) < MakeDate(Year(Now()), 1) AND
        (items.itype = 'AUDIOBOOK' OR
          items.itype = 'FLPLAYAWAY' OR
          items.itype = 'NAUDNEW')) OR
      (Year(items.dateaccessioned) < MakeDate(Year(Now()), 1) AND
        ((items.itype = 'DIGITAL' AND
            (items.ccode = 'BOOKONCD' OR
              items.ccode = 'BOOKONMP')) OR
          (items.itype = 'KIT' AND
            (items.ccode = 'BOOKONCD' OR
              items.ccode = 'BOOKONMP')) OR
          (items.itype = 'LAUNCHPAD' AND
            (items.ccode = 'BOOKONCD')) OR
          (items.itype = 'MUSIC' AND
            (items.ccode = 'BOOKONCD')) OR
          (items.itype = 'PSPECIAL' AND
            (items.ccode = 'BOOKONCD' OR
              items.ccode = 'BOOKONMP')) OR
          (items.itype = 'PUNC' AND
            (items.ccode = 'BOOKONCD')) OR
          (items.itype = 'REFERENCE' AND
            (items.ccode = 'BOOKONCD' OR
              items.ccode = 'BOOKONMP'))))
    GROUP BY
      items.homebranch) AUDIO_T ON branches.branchcode = AUDIO_T.homebranch
  LEFT JOIN
  (SELECT
      items.homebranch,
      count(*) AS COUNT
    FROM
      items
    WHERE
      Year(items.dateaccessioned) < MakeDate(Year(Now()), 1)
    GROUP BY
      items.homebranch) ALL_ITEMS ON branches.branchcode = ALL_ITEMS.homebranch
  LEFT JOIN
  (SELECT
      items.homebranch,
      count(*) AS COUNT
    FROM
      items
    WHERE
      (Year(items.dateaccessioned) < MakeDate(Year(Now()), 1) AND
        (items.itype = 'NVIDEO' OR
          items.itype = 'NVIDLH' OR
          items.itype = 'NVIDNEW' OR
          items.itype = 'NVIDTV')) OR
      (Year(items.dateaccessioned) < MakeDate(Year(Now()), 1) AND
        ((items.itype = 'DIGITAL' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'EQUIPMENT' AND
            (items.ccode = 'VID_M')) OR
          (items.itype = 'GAME' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'HCC_RES' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'KITS' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'LOCALHOLD' AND
            (items.ccode = 'VID_B' OR
              items.ccode = 'VID_C' OR
              items.ccode = 'VID_D')) OR
          (items.itype = 'MAGAZINE' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'MUSIC' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'NREL_TOOL' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'PSPECIAL' AND
            (items.ccode = 'VID_B' OR
              items.ccode = 'VID_C' OR
              items.ccode = 'VID_D')) OR
          (items.itype = 'PUNC' AND
            (items.ccode = 'VID_B' OR
              items.ccode = 'VID_D')) OR
          (items.itype = 'REFERENCE' AND
            (items.ccode = 'VHS' OR
              items.ccode = 'VID_D'))))
    GROUP BY
      items.homebranch) VIDEO_T ON branches.branchcode = VIDEO_T.homebranch
  LEFT JOIN
  (SELECT
      items.homebranch,
      Count(items.itemnumber) AS COUNT
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
      items.homebranch) ALL_BOOKS ON ALL_BOOKS.homebranch = branches.branchcode
  LEFT JOIN
  (SELECT
      items.homebranch,
      count(*) AS COUNT
    FROM
      items
    WHERE
      (Year(items.dateaccessioned) < MakeDate(Year(Now()), 1) AND
        ((items.itype = 'NVIDEO' AND
            (items.ccode <> 'VHS' AND
              items.ccode <> 'VID_M')) OR
          (items.itype = 'NVIDLH' AND
            (items.ccode <> 'VHS' AND
              items.ccode <> 'VID_M')) OR
          (items.itype = 'NVIDNEW' AND
            (items.ccode <> 'VHS' AND
              items.ccode <> 'VID_M')) OR
          (items.itype = 'NVIDTV' AND
            (items.ccode <> 'VHS' AND
              items.ccode <> 'VID_M')))) OR
      (Year(items.dateaccessioned) < MakeDate(Year(Now()), 1) AND
        ((items.itype = 'DIGITAL' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'GAME' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'HCC_RES' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'KITS' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'LOCALHOLD' AND
            (items.ccode = 'VID_B' OR
              items.ccode = 'VID_C' OR
              items.ccode = 'VID_D')) OR
          (items.itype = 'MAGAZINE' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'MUSIC' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'NREL_TOOL' AND
            (items.ccode = 'VID_D')) OR
          (items.itype = 'PSPECIAL' AND
            (items.ccode = 'VID_B' OR
              items.ccode = 'VID_C' OR
              items.ccode = 'VID_D')) OR
          (items.itype = 'PUNC' AND
            (items.ccode = 'VID_B' OR
              items.ccode = 'VID_D')) OR
          (items.itype = 'REFERENCE' AND
            (items.ccode = 'VID_D'))))
    GROUP BY
      items.homebranch) VIDEO_DVD_T ON VIDEO_DVD_T.homebranch =
      branches.branchcode
GROUP BY
  branches.branchcode

























