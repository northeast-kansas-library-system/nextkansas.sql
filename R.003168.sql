/*
R.003168

----------

Name: GHW - Narrow down
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2019-02-11 23:05:21
Modified on: 2019-02-11 23:05:21
Date last run: 2019-02-15 21:53:41

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat(
     '<a href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=3166&phase=Run+this+report&m_name=searchterm&sql_params=',
    Replace(Left(Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", ""), 3), " ","+"),
    '" target="_blank">Run targeted search</a>'
  ) AS ASEARCH,
  Left(Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", ""), 3) AS author,
  Count(Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", "")) AS AUTHOR_COUNT
FROM
  biblio
WHERE
  Left(Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", ""), 3) LIKE "A%"
GROUP BY
  Left(Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", ""), 3)



