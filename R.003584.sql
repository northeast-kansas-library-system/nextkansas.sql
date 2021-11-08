/*
R.003584

----------

Name: LibraryIQ - Location codes tab (setup)
Created by: George H Williams

----------

Group: LibraryIQ
     Setup

Created on: 2021-10-11 17:52:44
Modified on: 2021-10-13 11:08:18
Date last run: 2021-10-29 17:23:01

----------

Public: 0
Expiry: 300

----------

#libraryiq #setup

----------
*/



SELECT
  Concat('Permanent Shelving Locations') AS Type,
  Concat('-') AS CODE,
  Concat('-') AS STAFF_DESCRIPTION,
  Concat('-') AS OPAC_DESCRIPTION,
  Concat('-') AS `Report Date`
UNION
SELECT
  Concat(''),
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac,
  DATE_FORMAT(CurDate(), "%Y.%m.%d")
FROM
  authorised_values
WHERE
  authorised_values.category = 'LOC'
UNION
SELECT
  Concat('Item types') AS Type,
  Concat('-') AS CODE,
  Concat('-') AS STAFF_DESCRIPTION,
  Concat('-') AS OPAC_DESCRIPTION,
  Concat('-') AS DATA_COLLECTED_ON
UNION
SELECT
  Concat(''),
  itemtypes.itemtype,
  itemtypes.description,
  itemtypes.description AS description1,
  DATE_FORMAT(CurDate(), "%Y.%m.%d")
FROM
  itemtypes
UNION
SELECT
  Concat('Collection codes') AS Type,
  Concat('-') AS CODE,
  Concat('-') AS STAFF_DESCRIPTION,
  Concat('-') AS OPAC_DESCRIPTION,
  Concat('-') AS DATA_COLLECTED_ON
UNION
SELECT
  Concat(''),
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac,
  DATE_FORMAT(CurDate(), "%Y.%m.%d")
FROM
  authorised_values
WHERE
  authorised_values.category = 'CCODE'

























