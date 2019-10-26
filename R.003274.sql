/*
R.003274

----------

Name: GHW - MEDIA to NVIDEO project
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-10-01 00:15:49
Modified on: 2019-10-16 14:33:21
Date last run: 2019-10-16 14:33:28

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  items.itemnumber,
  items.itype
FROM
  items
WHERE
  items.itype LIKE 'MEDIA'
GROUP BY
  items.itemnumber,
  items.itype



