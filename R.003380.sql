/*
R.003380

----------

Name: koha-US Demo 9
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 09:48:43
Modified on: 2020-11-23 09:48:43
Date last run: 2020-11-23 11:39:37

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branchess.branchname,
  CKOS_RENEWALS.CKO_PLUS_RENEW,
  CKO_RENEW_BOOK.CKO_PLUS_RENEW AS CKO_RENEW_BOOK

FROM
  (SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches) branchess 
      
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
      
ON CKOS_RENEWALS.branch = branchess.branchcode LEFT JOIN
  (SELECT
      statistics.branch,
      Count(statistics.datetime) AS CKO_PLUS_RENEW
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      statistics.itemtype = 'BOOK'
    GROUP BY
      statistics.branch) CKO_RENEW_BOOK 
      
ON CKO_RENEW_BOOK.branch = branchess.branchcode

GROUP BY
  branchess.branchname,
  CKOS_RENEWALS.CKO_PLUS_RENEW,
  CKO_RENEW_BOOK.CKO_PLUS_RENEW
ORDER BY
  branchess.branchname



