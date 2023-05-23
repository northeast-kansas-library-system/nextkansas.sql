/*
R.003719

----------

Name: GHW - Bib IDs for MARCIVE
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-03-17 12:25:53
Modified on: 2023-04-01 11:06:20
Date last run: 2023-04-01 11:06:33

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.biblionumber AS BIBLIO_NUMBER
FROM
  items JOIN
  itemtypes ON itemtypes.itemtype = items.itype
WHERE
  items.itype NOT LIKE 'R_CMP_LAP' AND
  items.itype NOT LIKE 'LAUNCHPAD' AND
  items.itype NOT LIKE 'COMPUTER' AND
  items.itype NOT LIKE 'NSOFT' AND
  items.itype NOT LIKE 'NELECT' AND
  items.itype NOT LIKE 'MIFI' AND
  items.itype NOT LIKE 'R_WIFI' AND
  items.itype NOT LIKE 'NELECOURSE' AND
  items.itype NOT LIKE 'ILL' AND
  items.itype NOT LIKE 'I_ILL' AND
  items.itype NOT LIKE 'I_ILL_07' AND
  items.itype NOT LIKE 'I_ILL_14' AND
  items.itype NOT LIKE 'I_ILL_21' AND
  items.itype NOT LIKE 'I_ILL_28' AND
  items.itype NOT LIKE 'NEQKEY' AND
  items.itype NOT LIKE 'R_K_STW' AND
  items.itype NOT LIKE 'R_ART' AND
  items.itype NOT LIKE 'NREL_BIKE' AND
  items.itype NOT LIKE 'NREL_TOY' AND
  items.itype NOT LIKE 'NREL_CLOTH' AND
  items.itype NOT LIKE 'NREL_COOK' AND
  items.itype NOT LIKE 'NEQUDIE' AND
  items.itype NOT LIKE 'EQUIPMENT' AND
  items.itype NOT LIKE 'R_PAS_PARK' AND
  items.itype NOT LIKE 'NPASS' AND
  items.itype NOT LIKE 'R_REC' AND
  items.itype NOT LIKE 'NREL_TOOL'
GROUP BY
  items.biblionumber

























