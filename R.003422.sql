/*
R.003422

----------

Name: GHW - Monthly 114 Monthly statistics master - Biblios total
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2021-02-04 21:38:26
Modified on: 2021-07-29 17:17:03
Date last run: 2021-09-01 00:15:03

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  'Total biblios on last day of last month' AS DESCRIPTION,
  count(*) AS COUNT
FROM
  biblio
WHERE
  biblio.datecreated < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
UNION
SELECT
  'Biblios added last month' AS DESCRIPTION,
  Count(*)
FROM
  biblio
WHERE
  Month(biblio.datecreated) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(biblio.datecreated) = Year(Now() - INTERVAL 1 MONTH)
UNION
SELECT
  'Biblios deleted last month' AS DESCRIPTION,
  Count(*)
FROM
  deletedbiblio
WHERE
  Month(deletedbiblio.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(deletedbiblio.timestamp) = Year(Now() - INTERVAL 1 MONTH)



