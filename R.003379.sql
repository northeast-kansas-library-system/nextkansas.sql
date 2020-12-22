/*
R.003379

----------

Name: koha-us Demo 8
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 09:44:41
Modified on: 2020-11-23 11:38:29
Date last run: 2020-11-23 12:21:35

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  BRANCHESS.branchname,
  Coalesce(CKOS_RENEWALS.CKO_PLUS_RENEW, "0") AS CKO
FROM
  (SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches) BRANCHESS 
      
LEFT JOIN

  (SELECT
     statistics.branch,
     Count(statistics.datetime) AS CKO_PLUS_RENEW
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch) CKOS_RENEWALS 
      
ON CKOS_RENEWALS.branch = BRANCHESS.branchcode

GROUP BY
  BRANCHESS.branchname,
  CKOS_RENEWALS.CKO_PLUS_RENEW



