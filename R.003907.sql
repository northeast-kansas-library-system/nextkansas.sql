/*
R.003907

----------

Name: GHW - Holds group test report
Created by: George Williams

----------

Group: -
     -

Created on: 2025-08-11 10:45:56
Modified on: 2025-08-13 09:20:30
Date last run: 2025-08-13 09:20:53

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  reserves.biblionumber,
  biblio.author,
  biblio.title,
  reserves.branchcode,
  reserves.priority
FROM
  reserves JOIN
  biblio ON reserves.biblionumber = biblio.biblionumber
WHERE
  reserves.biblionumber = 1405860
GROUP BY
  reserves.reserve_id
ORDER BY
  reserves.priority

























