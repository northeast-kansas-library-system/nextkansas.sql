/*
R.002868

----------

Name: GHW - YE 9.1b-9.5
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly Stats Suite

Created on: 2017-01-01 22:40:38
Modified on: 2020-12-31 15:05:32
Date last run: 2021-01-17 20:27:39

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
  (Coalesce(ALL_ITEMS.COUNT, 0) - (Coalesce(ALL_BOOKS.Count_itemnumber, 0) +
  Coalesce(AUDIO_T.COUNT, 0) + (Coalesce(VIDEO_T.COUNT, 0)))) AS '9.5_OTHER_T'
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
              items.itype = 'LOCALHOLD2' OR
              items.itype = 'PBBKNEW' OR
              items.itype = 'WALKIN2')) OR
      (Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 YEAR) AND
          (items.itype = 'LOCALHOLD' OR
              items.itype = 'REFERENCE' OR
              items.itype = 'WALKIN' OR
              items.itype = 'XXX') AND
          (items.ccode = 'BILINGUAL' OR
              items.ccode = 'BIOGRAPHY' OR
              items.ccode = 'BOARDBK' OR
              items.ccode = 'EASY' OR
              items.ccode = 'EDUCATION' OR
              items.ccode = 'FICTION' OR
              items.ccode = 'GENEALOGY' OR
              items.ccode = 'GRAPHIC' OR
              items.ccode = 'HOLIDAY' OR
              items.ccode = 'INSPRATION' OR
              items.ccode = 'KANSAS' OR
              items.ccode = 'LARGEPRINT' OR
              items.ccode = 'LARGEPRNF' OR
              items.ccode = 'MYSTERY' OR
              items.ccode = 'NONFICTION' OR
              items.ccode = 'OVERSIZE' OR
              items.ccode = 'PAPERBACK' OR
              items.ccode = 'PARENTING' OR
              items.ccode = 'PROFCOLL' OR
              items.ccode = 'READER' OR
              items.ccode = 'ROMANCE' OR
              items.ccode = 'SF-FANT' OR
              items.ccode = 'SPANISH' OR
              items.ccode = 'WESTERN'))
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
              deleteditems.itype = 'LOCALHOLD2' OR
              deleteditems.itype = 'PBBKNEW' OR
              deleteditems.itype = 'WALKIN2')) OR
      (Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 YEAR) AND
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
              items.itype = 'NEWAUDIO')) OR
      (Year(items.dateaccessioned) < MakeDate(Year(Now()), 1) AND
          items.itype <> 'AUDIOBOOK' AND
          items.itype <> 'FLPLAYAWAY' AND
          items.itype <> 'NEWAUDIO' AND
          items.itype <> 'BOOK' AND
          items.itype <> 'LOCALHOLD2' AND
          items.itype <> 'PBBKNEW' AND
          items.itype <> 'WALKIN2' AND
          items.itype <> 'LOCALHOLD1' AND
          items.itype <> 'MEDIA' AND
          items.itype <> 'NEWMEDIA' AND
          items.itype <> 'WALKIN1' AND
          (items.ccode = 'BOOKONCASS' OR
              items.ccode = 'BOOKONCD' OR
              items.ccode = 'BOOKONMP'))
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
          (items.itype = 'LOCALHOLD1' OR
              items.itype = 'MEDIA' OR
              items.itype = 'NEWMEDIA' OR
              items.itype = 'WALKIN1')) OR
      (Year(items.dateaccessioned) < MakeDate(Year(Now()), 1) AND
          items.itype <> 'LOCALHOLD1' AND
          items.itype <> 'MEDIA' AND
          items.itype <> 'NEWMEDIA' AND
          items.itype <> 'WALKIN1' AND
          items.itype <> 'BOOK' AND
          items.itype <> 'LOCALHOLD2' AND
          items.itype <> 'PBBKNEW' AND
          items.itype <> 'WALKIN2' AND
          items.itype <> 'AUDIOBOOK' AND
          items.itype <> 'FLPLAYAWAY' AND
          items.itype <> 'NEWAUDIO' AND
          (items.ccode = 'BLU-RAY' OR
              items.ccode = 'COMBO' OR
              items.ccode = 'DVD' OR
              items.ccode = 'TVSERIES' OR
              items.ccode = 'VHS'))
    GROUP BY
      items.homebranch) VIDEO_T ON branches.branchcode = VIDEO_T.homebranch
  LEFT JOIN
  (SELECT
      items.homebranch,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      (Year(items.dateaccessioned) < MakeDate(Year(Now()), 1) AND
          (items.itype = 'BOOK' OR
              items.itype = 'LOCALHOLD2' OR
              items.itype = 'PBBKNEW' OR
              items.itype = 'WALKIN2')) OR
      (Year(items.dateaccessioned) < MakeDate(Year(Now()), 1) AND
          (items.itype = 'LOCALHOLD' OR
              items.itype = 'REFERENCE' OR
              items.itype = 'WALKIN' OR
              items.itype = 'XXX') AND
          (items.ccode = 'BILINGUAL' OR
              items.ccode = 'BIOGRAPHY' OR
              items.ccode = 'BOARDBK' OR
              items.ccode = 'EASY' OR
              items.ccode = 'EDUCATION' OR
              items.ccode = 'FICTION' OR
              items.ccode = 'GENEALOGY' OR
              items.ccode = 'GRAPHIC' OR
              items.ccode = 'HOLIDAY' OR
              items.ccode = 'INSPRATION' OR
              items.ccode = 'KANSAS' OR
              items.ccode = 'LARGEPRINT' OR
              items.ccode = 'LARGEPRNF' OR
              items.ccode = 'MYSTERY' OR
              items.ccode = 'NONFICTION' OR
              items.ccode = 'OVERSIZE' OR
              items.ccode = 'PAPERBACK' OR
              items.ccode = 'PARENTING' OR
              items.ccode = 'PROFCOLL' OR
              items.ccode = 'READER' OR
              items.ccode = 'ROMANCE' OR
              items.ccode = 'SF-FANT' OR
              items.ccode = 'SPANISH' OR
              items.ccode = 'WESTERN'))
    GROUP BY
      items.homebranch) ALL_BOOKS ON ALL_BOOKS.homebranch = branches.branchcode
GROUP BY
  branches.branchcode



