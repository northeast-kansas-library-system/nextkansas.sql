/*
R.003275

----------

Name: GHW - ADMINREPORT - Quick count
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-10-01 01:00:55
Modified on: 2019-10-01 01:00:55
Date last run: 2019-10-01 02:39:12

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Count(*) AS COUNT
FROM
  items
WHERE
  items.itype = 'MEDIA'

























