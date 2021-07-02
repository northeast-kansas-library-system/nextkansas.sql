/*
R.003519

----------

Name: sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-06-11 09:57:11
Modified on: 2021-06-11 10:04:04
Date last run: 2021-06-28 16:29:12

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  biblioimages.imagenumber,
  biblioimages.biblionumber,
  biblioimages.mimetype,
  BASE64(biblioimages.imagefile),
  biblioimages.thumbnail,
  biblioimages.timestamp,
  CAST(biblioimages.timestamp AS DATE) AS date
FROM
  biblioimages
WHERE
  (biblioimages.imagenumber = 41 OR
    biblioimages.imagenumber = 42 OR
    biblioimages.imagenumber = 43)
LIMIT 25



