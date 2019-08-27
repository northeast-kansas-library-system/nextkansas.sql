/*
R.002334

----------

Name: unknown
Created by: Heather Braum

----------

Group: -
     -

Created on: 2014-08-19 22:38:13
Modified on: 2018-07-02 10:30:21
Date last run: 2018-07-02 10:51:39

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT DISTINCT
  biblio.title,
  Count(biblio.title),
  Concat('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=1368&sql_params=%25', biblio.author, '%25\" target="_blank">', biblio.author, '</a>') AS "Report of Author",
  GROUP_CONCAT(DISTINCT biblio.biblionumber SEPARATOR ', ') AS bibnumbers,
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\">', biblio.biblionumber, '</a>') AS "bibnumber linked"
FROM
  biblio
GROUP BY
  biblio.title
HAVING
  Count(biblio.title) > 1
ORDER BY
  biblio.biblionumber DESC
LIMIT 6000



