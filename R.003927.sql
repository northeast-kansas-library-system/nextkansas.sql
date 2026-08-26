/*
R.003927

----------

Name: GHW - Looker Studio 03 - test
Created by: George Williams

----------

Group: -
     -

Created on: 2025-11-12 18:06:38
Modified on: 2025-11-12 22:43:18
Date last run: 2026-08-25 10:30:32

----------

Public: 1
Expiry: 900

----------



----------
*/



SELECT
  branches.branchname,
  Coalesce(Sum(DISTINCT items_by_type.PRINT), 0) AS PRINT,
  Coalesce(Sum(DISTINCT items_by_type.AUDIOBOOK), 0) AS AUDIOBOOK,
  Coalesce(Sum(DISTINCT items_by_type.MUSIC), 0) AS MUSIC,
  Coalesce(Sum(DISTINCT items_by_type.VIDEO_RECORDING), 0) AS VIDEO_RECORDING,
  Coalesce(Sum(DISTINCT items_by_type.VIDEO_GAME), 0) AS VIDEO_GAME,
  Coalesce(Sum(DISTINCT items_by_type.OTHER), 0) AS OTHER
FROM
  branches LEFT JOIN
  (SELECT
      items.homebranch AS HOMEBRANCH,
      Count(CASE
        WHEN
          items.itype = 'BOOK' OR items.itype = 'P_USD454' OR
          items.itype = 'LOCALHOLD2' OR items.itype = 'PBBKNEW' OR
          items.itype = 'PBBKWALK' OR items.itype = 'PBBKCLUB' OR
          items.itype = 'P_MAG' OR items.itype = 'P_MAG_N' OR
          items.itype = 'PPHAM' OR items.itype = 'P_REF' OR
          items.itype = 'LOCALHOLD' OR items.itype = 'PSPECIAL'
        THEN 1
      END) AS PRINT,
      Count(CASE
        WHEN
          items.itype = 'N_AB' OR items.itype = 'N_AB_M' OR
          items.itype = 'N_AB_NEW'
        THEN 1
      END) AS AUDIOBOOK,
      Count(CASE
        WHEN
          items.itype = 'MUSIC'
        THEN 1
      END) AS MUSIC,
      Count(CASE
        WHEN
          items.itype = 'NVIDEO' OR items.itype = 'NVIDLH' OR
          items.itype = 'NVIDNEW' OR items.itype = 'NVIDWALK' OR
          items.itype = 'NVIDTV'
        THEN 1
      END) AS VIDEO_RECORDING,
      Count(CASE
        WHEN
          items.itype = 'ITNVIDGAM'
        THEN 1
      END) AS VIDEO_GAME,
      Count(CASE
        WHEN
          items.itype IS NULL OR items.itype = 'PUNC' OR
          items.itype = 'R_CMP_LAP' OR items.itype = 'LAUNCHPAD' OR
          items.itype = 'COMPUTER' OR items.itype = 'NSOFT' OR
          items.itype = 'NELECT' OR items.itype = 'R_WIFI' OR
          items.itype = 'DIGITAL' OR items.itype = 'NELECOURSE' OR
          items.itype = 'I_ILL' OR items.itype = 'ILL' OR
          items.itype = 'I_ILL_07' OR items.itype = 'I_ILL_14' OR
          items.itype = 'I_ILL_21' OR items.itype = 'I_ILL_28' OR
          items.itype = 'NEQKEY' OR items.itype = 'KITS' OR
          items.itype = 'HCC_RES' OR items.itype = 'NROOM' OR
          items.itype = 'R_K_STW' OR items.itype = 'ITRART' OR
          items.itype = 'R_EQ_AV' OR items.itype = 'NREL_BIKE' OR
          items.itype = 'ITRTOY' OR items.itype = 'NREL_CLOTH' OR
          items.itype = 'NREL_COOK' OR items.itype = 'NEQUDIE' OR
          items.itype = 'EQUIPMENT' OR items.itype = 'R_PAS_PARK' OR
          items.itype = 'NPASS' OR items.itype = 'R_INST' OR
          items.itype = 'R_REC' OR items.itype = 'NREL_TOOL'
        THEN 1
      END) AS OTHER
    FROM
      items
    WHERE
      items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL
      1 MONTH)), 1)
    GROUP BY
      items.homebranch
    UNION
    SELECT
      deleteditems.homebranch AS HOMEBRANCH,
      Coalesce(Count(CASE
        WHEN
          deleteditems.itype = 'BOOK' OR deleteditems.itype = 'P_USD454' OR
          deleteditems.itype = 'LOCALHOLD2' OR deleteditems.itype = 'PBBKNEW' OR
          deleteditems.itype = 'PBBKWALK' OR deleteditems.itype = 'PBBKCLUB' OR
          deleteditems.itype = 'P_MAG' OR deleteditems.itype = 'P_MAG_N' OR
          deleteditems.itype = 'PPHAM' OR deleteditems.itype = 'P_REF' OR
          deleteditems.itype = 'LOCALHOLD' OR deleteditems.itype = 'PSPECIAL'
        THEN 1
      END), 0) AS PRINT,
      Count(CASE
        WHEN
          deleteditems.itype = 'N_AB' OR deleteditems.itype = 'N_AB_M' OR
          deleteditems.itype = 'N_AB_NEW'
        THEN 1
      END) AS AUDIOBOOK,
      Count(CASE
        WHEN
          deleteditems.itype = 'MUSIC'
        THEN 1
      END) AS MUSIC,
      Count(CASE
        WHEN
          deleteditems.itype = 'NVIDEO' OR deleteditems.itype = 'NVIDLH' OR
          deleteditems.itype = 'NVIDNEW' OR deleteditems.itype = 'NVIDWALK' OR
          deleteditems.itype = 'NVIDTV'
        THEN 1
      END) AS VIDEO_RECORDING,
      Count(CASE
        WHEN
          deleteditems.itype = 'ITNVIDGAM'
        THEN 1
      END) AS VIDEO_GAME,
      Count(CASE
        WHEN
          deleteditems.itype IS NULL OR deleteditems.itype = 'PUNC' OR
          deleteditems.itype = 'R_CMP_LAP' OR deleteditems.itype = 'LAUNCHPAD'
          OR deleteditems.itype = 'COMPUTER' OR deleteditems.itype = 'NSOFT' OR
          deleteditems.itype = 'NELECT' OR deleteditems.itype = 'R_WIFI' OR
          deleteditems.itype = 'DIGITAL' OR deleteditems.itype = 'NELECOURSE' OR
          deleteditems.itype = 'I_ILL' OR deleteditems.itype = 'ILL' OR
          deleteditems.itype = 'I_ILL_07' OR deleteditems.itype = 'I_ILL_14' OR
          deleteditems.itype = 'I_ILL_21' OR deleteditems.itype = 'I_ILL_28' OR
          deleteditems.itype = 'NEQKEY' OR deleteditems.itype = 'KITS' OR
          deleteditems.itype = 'HCC_RES' OR deleteditems.itype = 'NROOM' OR
          deleteditems.itype = 'R_K_STW' OR deleteditems.itype = 'ITRART' OR
          deleteditems.itype = 'R_EQ_AV' OR deleteditems.itype = 'NREL_BIKE' OR
          deleteditems.itype = 'ITRTOY' OR deleteditems.itype = 'NREL_CLOTH' OR
          deleteditems.itype = 'NREL_COOK' OR deleteditems.itype = 'NEQUDIE' OR
          deleteditems.itype = 'EQUIPMENT' OR deleteditems.itype = 'R_PAS_PARK'
          OR deleteditems.itype = 'NPASS' OR deleteditems.itype = 'R_INST' OR
          deleteditems.itype = 'R_REC' OR deleteditems.itype = 'NREL_TOOL'
        THEN 1
      END) AS OTHER
    FROM
      deleteditems
    WHERE
      deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1
      MONTH)), 1) AND
      deleteditems.deleted_on >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1
      MONTH)), 1)
    GROUP BY
      deleteditems.homebranch
    ORDER BY
      HOMEBRANCH) items_by_type ON items_by_type.HOMEBRANCH =
      branches.branchcode
GROUP BY
  branches.branchname

























