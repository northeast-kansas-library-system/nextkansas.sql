/*
R.003277

----------

Name: GHW - ADMINREPORT - TONGANOXIE push
Created by: George Williams

----------

Group: -
     -

Created on: 2019-10-04 16:07:57
Modified on: 2019-10-10 08:50:15
Date last run: 2019-10-10 08:50:33

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  reserves.branchcode,
  Concat('Open in new window') AS LINK,
  Count(reserves.reserve_id) AS Count_reserve_id,
  reserves.suspend_until
FROM
  reserves
WHERE
  reserves.branchcode LIKE <> AND
  reserves.found IS NULL AND
  reserves.suspend_until = <>
GROUP BY
  reserves.borrowernumber,
  reserves.branchcode,
  reserves.found,
  reserves.suspend,
  reserves.suspend_until
ORDER BY
  reserves.borrowernumber

























