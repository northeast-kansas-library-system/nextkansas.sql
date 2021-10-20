/*
R.003583

----------

Name: LibraryIQ - Other tab (setup)
Created by: George H Williams

----------

Group: LibraryIQ
     Setup

Created on: 2021-10-11 17:43:01
Modified on: 2021-10-13 11:08:25
Date last run: 2021-10-13 11:21:39

----------

Public: 0
Expiry: 300

----------

#libraryiq #setup

----------
*/



SELECT
  Concat('Damaged statuses') AS STATUS_TYPE,
  Concat('-') AS STATUS_CODE,
  Concat('-') AS STAFF_DESCRIPTION,
  Concat('-') AS OPAC_DESCRIPTION,
  Concat('-') AS `Report Date`
UNION
SELECT
  Concat(''),
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac,
  DATE_FORMAT(CurDate(), "%Y.%m.%d") AS `Data collected on`
FROM
  authorised_values
WHERE
  authorised_values.category = 'DAMAGED'
GROUP BY
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac
UNION
SELECT
  Concat('Lost statuses') AS STATUS_TYPE,
  Concat('-') AS STATUS_CODE,
  Concat('-') AS STAFF_DESCRIPTION,
  Concat('-') AS OPAC_DESCRIPTION,
  Concat('-') AS DATA_COLLECTED_ON
UNION
SELECT
  Concat(''),
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac,
  DATE_FORMAT(CurDate(), "%Y.%m.%d") AS `Data collected on`
FROM
  authorised_values
WHERE
  authorised_values.category = 'LOST'
GROUP BY
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac
UNION
SELECT
  Concat('Not for loan statuses') AS STATUS_TYPE,
  Concat('-') AS STATUS_CODE,
  Concat('-') AS STAFF_DESCRIPTION,
  Concat('-') AS OPAC_DESCRIPTION,
  Concat('-') AS DATA_COLLECTED_ON
UNION
SELECT
  Concat(''),
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac,
  DATE_FORMAT(CurDate(), "%Y.%m.%d") AS `Data collected on`
FROM
  authorised_values
WHERE
  authorised_values.category = 'NOT_LOAN'
GROUP BY
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac
UNION
SELECT
  Concat('Withdrawan statuses') AS STATUS_TYPE,
  Concat('-') AS STATUS_CODE,
  Concat('-') AS STAFF_DESCRIPTION,
  Concat('-') AS OPAC_DESCRIPTION,
  Concat('-') AS DATA_COLLECTED_ON
UNION
SELECT
  Concat(''),
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac,
  DATE_FORMAT(CurDate(), "%Y.%m.%d") AS `Data collected on`
FROM
  authorised_values
WHERE
  authorised_values.category = 'WITHDRAWN'
GROUP BY
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.lib_opac

























