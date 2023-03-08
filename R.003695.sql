/*
R.003695

----------

Name: GHW - YE 9.1a-9.4
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-01-03 11:29:45
Modified on: 2023-01-03 11:29:45
Date last run: 2023-02-06 15:08:00

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT branches.branchname,
  Sum(
    Coalesce(books_start_items.Count_itemnumber, 0) + 
    Coalesce(books_start_deleteditems.Count_itemnumber, 0)
  ) AS BOOKS_START_OF_LAST_YEAR,
  Coalesce(books_added.Count_itemnumber, 0) AS BOOKS_ADDED_LAST_YEAR,
  Coalesce(books_deleted.Count_itemnumber, 0) AS BOOKS_DELETED_LAST_YEAR,
  Sum(
    Coalesce(total_audio_items.Count_itemnumber, 0) + 
    Coalesce(total_audio_deleteditems.Count_itemnumber, 0)
  ) AS TOTAL_AUDIO_START_OF_THIS_YEAR,
  Sum(
    Coalesce(total_video_items.Count_itemnumber, 0) + 
    Coalesce(total_video_deleteditems.Count_itemnumber, 0)
  ) AS TOTAL_VIDEO_START_OF_THIS_YEAR,
  Sum(
    Coalesce(total_other_items.Count_itemnumber, 0) + 
    Coalesce(total_other_deleteditems.Count_itemnumber, 0)
  ) AS TOTAL_OTHER_START_OF_THIS_YEAR
FROM branches
  LEFT JOIN 
  (
    SELECT items.homebranch,
      Count(DISTINCT items.itemnumber) AS Count_itemnumber
    FROM items
    WHERE Year(items.dateaccessioned) < 2022
      AND (
        items.itype = 'BOOK'
        OR items.itype = 'LOCALHOLD2'
        OR items.itype = 'PBBKNEW'
        OR items.itype = 'PBBKWALK'
        OR items.itype = 'LOCALHOLD'
        OR items.itype = 'PSPECIAL'
      )
    GROUP BY items.homebranch
  ) books_start_items ON books_start_items.homebranch = branches.branchcode
  LEFT JOIN 
  (
    SELECT Count(DISTINCT deleteditems.itemnumber) AS Count_itemnumber,
      deleteditems.homebranch
    FROM deleteditems
    WHERE Year(deleteditems.dateaccessioned) < 2022
      AND (
        Year(deleteditems.timestamp) = 2022
        OR Year(deleteditems.timestamp) = 2023
      )
      AND (
        deleteditems.itype = 'BOOK'
        OR deleteditems.itype = 'LOCALHOLD2'
        OR deleteditems.itype = 'PBBKNEW'
        OR deleteditems.itype = 'PBBKWALK'
        OR deleteditems.itype = 'LOCALHOLD'
        OR deleteditems.itype = 'PSPECIAL'
      )
    GROUP BY deleteditems.homebranch
  ) books_start_deleteditems ON books_start_deleteditems.homebranch = branches.branchcode
  LEFT JOIN 
  (
    SELECT items.homebranch,
      Count(DISTINCT items.itemnumber) AS Count_itemnumber
    FROM items
    WHERE Year(items.dateaccessioned) = 2022
      AND (
        items.itype = 'BOOK'
        OR items.itype = 'LOCALHOLD2'
        OR items.itype = 'PBBKNEW'
        OR items.itype = 'PBBKWALK'
        OR items.itype = 'LOCALHOLD'
        OR items.itype = 'PSPECIAL'
      )
    GROUP BY items.homebranch
  ) books_added ON books_added.homebranch = branches.branchcode
  LEFT JOIN 
  (
    SELECT Count(DISTINCT deleteditems.itemnumber) AS Count_itemnumber,
      deleteditems.homebranch
    FROM deleteditems
    WHERE Year(deleteditems.timestamp) = 2022
      AND (
        deleteditems.itype = 'BOOK'
        OR deleteditems.itype = 'LOCALHOLD2'
        OR deleteditems.itype = 'PBBKNEW'
        OR deleteditems.itype = 'PBBKWALK'
        OR deleteditems.itype = 'LOCALHOLD'
        OR deleteditems.itype = 'PSPECIAL'
      )
    GROUP BY deleteditems.homebranch
  ) books_deleted ON books_deleted.homebranch = branches.branchcode
  LEFT JOIN 
  (
    SELECT Count(DISTINCT items.itemnumber) AS Count_itemnumber,
      items.homebranch
    FROM items
    WHERE Year(items.dateaccessioned) <> 2023
      AND (
        items.itype = 'AUDIOBOOK'
        OR items.itype = 'N_AB'
        OR items.itype = 'FLPLAYAWAY'
        OR items.itype = 'N_AB_M'
        OR items.itype = 'N_AB_NEW'
        OR items.itype = 'NAUDNEW'
        OR items.itype = 'MUSIC'
      )
    GROUP BY items.homebranch
  ) total_audio_items ON total_audio_items.homebranch = branches.branchcode
  LEFT JOIN 
  (
    SELECT Count(DISTINCT deleteditems.itemnumber) AS Count_itemnumber,
      deleteditems.homebranch
    FROM deleteditems
    WHERE Year(deleteditems.timestamp) = 2023
      AND (
        deleteditems.itype = 'AUDIOBOOK'
        OR deleteditems.itype = 'N_AB'
        OR deleteditems.itype = 'FLPLAYAWAY'
        OR deleteditems.itype = 'N_AB_M'
        OR deleteditems.itype = 'N_AB_NEW'
        OR deleteditems.itype = 'NAUDNEW'
        OR deleteditems.itype = 'MUSIC'
      )
      AND Year(deleteditems.dateaccessioned) < 2023
    GROUP BY deleteditems.homebranch
  ) total_audio_deleteditems ON total_audio_deleteditems.homebranch = branches.branchcode
  LEFT JOIN 
  (
    SELECT Count(DISTINCT items.itemnumber) AS Count_itemnumber,
      items.homebranch
    FROM items
    WHERE Year(items.dateaccessioned) <> 2023
      AND items.itype LIKE 'NVID%'
    GROUP BY items.homebranch
  ) total_video_items ON total_video_items.homebranch = branches.branchcode
  LEFT JOIN 
  (
    SELECT Count(DISTINCT deleteditems.itemnumber) AS Count_itemnumber,
      deleteditems.homebranch
    FROM deleteditems
    WHERE Year(deleteditems.timestamp) = 2023
      AND deleteditems.itype LIKE 'NVID%'
      AND Year(deleteditems.dateaccessioned) < 2023
    GROUP BY deleteditems.homebranch
  ) total_video_deleteditems ON total_video_deleteditems.homebranch = branches.branchcode
  LEFT JOIN 
  (
    SELECT Count(DISTINCT items.itemnumber) AS Count_itemnumber,
      items.homebranch
    FROM items
    WHERE Year(items.dateaccessioned) <> 2023
      AND (
        items.itype = 'COMPUTER'
        OR items.itype = 'DIGITAL'
        OR items.itype = 'EQUIPMENT'
        OR items.itype = 'GAME'
        OR items.itype = 'HCC_RES'
        OR items.itype = 'I_ILL'
        OR items.itype = 'I_ILL_07'
        OR items.itype = 'I_ILL_14'
        OR items.itype = 'I_ILL_21'
        OR items.itype = 'I_ILL_28'
        OR items.itype = 'ILL'
        OR items.itype = 'KITS'
        OR items.itype = 'LAUNCHPAD'
        OR items.itype = 'MAGAZINE'
        OR items.itype = 'MIFI'
        OR items.itype = 'NELECOURSE'
        OR items.itype = 'NELECT'
        OR items.itype = 'NEQKEY'
        OR items.itype = 'NEQUDIE'
        OR items.itype = 'NPASS'
        OR items.itype = 'NREL_BIKE'
        OR items.itype = 'NREL_CLOTH'
        OR items.itype = 'NREL_COOK'
        OR items.itype = 'NREL_TOOL'
        OR items.itype = 'NREL_TOY'
        OR items.itype = 'NROOM'
        OR items.itype = 'NSOFT'
        OR items.itype = 'P_MAG'
        OR items.itype = 'P_MAG_N'
        OR items.itype = 'P_REF'
        OR items.itype = 'PBBKCLUB'
        OR items.itype = 'PMAGNEW'
        OR items.itype = 'PPHAM'
        OR items.itype = 'PUNC'
        OR items.itype = 'R_ART'
        OR items.itype = 'R_CMP_LAP'
        OR items.itype = 'R_K_STW'
        OR items.itype = 'R_PAS_PARK'
        OR items.itype = 'R_REC'
        OR items.itype = 'R_WIFI'
      )
    GROUP BY items.homebranch
  ) total_other_items ON total_other_items.homebranch = branches.branchcode
  LEFT JOIN 
  (
    SELECT Count(DISTINCT deleteditems.itemnumber) AS Count_itemnumber,
      deleteditems.homebranch
    FROM deleteditems
    WHERE Year(deleteditems.timestamp) = 2023
      AND Year(deleteditems.dateaccessioned) < 2023
      AND (
        deleteditems.itype = 'COMPUTER'
        OR deleteditems.itype = 'DIGITAL'
        OR deleteditems.itype = 'EQUIPMENT'
        OR deleteditems.itype = 'GAME'
        OR deleteditems.itype = 'HCC_RES'
        OR deleteditems.itype = 'I_ILL'
        OR deleteditems.itype = 'I_ILL_07'
        OR deleteditems.itype = 'I_ILL_14'
        OR deleteditems.itype = 'I_ILL_21'
        OR deleteditems.itype = 'I_ILL_28'
        OR deleteditems.itype = 'ILL'
        OR deleteditems.itype = 'KITS'
        OR deleteditems.itype = 'LAUNCHPAD'
        OR deleteditems.itype = 'MAGAZINE'
        OR deleteditems.itype = 'MIFI'
        OR deleteditems.itype = 'NELECOURSE'
        OR deleteditems.itype = 'NELECT'
        OR deleteditems.itype = 'NEQKEY'
        OR deleteditems.itype = 'NEQUDIE'
        OR deleteditems.itype = 'NPASS'
        OR deleteditems.itype = 'NREL_BIKE'
        OR deleteditems.itype = 'NREL_CLOTH'
        OR deleteditems.itype = 'NREL_COOK'
        OR deleteditems.itype = 'NREL_TOOL'
        OR deleteditems.itype = 'NREL_TOY'
        OR deleteditems.itype = 'NROOM'
        OR deleteditems.itype = 'NSOFT'
        OR deleteditems.itype = 'P_MAG'
        OR deleteditems.itype = 'P_MAG_N'
        OR deleteditems.itype = 'P_REF'
        OR deleteditems.itype = 'PBBKCLUB'
        OR deleteditems.itype = 'PMAGNEW'
        OR deleteditems.itype = 'PPHAM'
        OR deleteditems.itype = 'PUNC'
        OR deleteditems.itype = 'R_ART'
        OR deleteditems.itype = 'R_CMP_LAP'
        OR deleteditems.itype = 'R_K_STW'
        OR deleteditems.itype = 'R_PAS_PARK'
        OR deleteditems.itype = 'R_REC'
        OR deleteditems.itype = 'R_WIFI'
      )
    GROUP BY deleteditems.homebranch
  ) total_other_deleteditems ON total_other_deleteditems.homebranch = branches.branchcode
GROUP BY branches.branchname

























