/*
R.003016

----------

Name: GHW - Last 50 bibliographic records added
Created by: George H Williams

----------

Group: Catalog Records and Items
     -

Created on: 2017-12-10 15:42:24
Modified on: 2017-12-10 15:42:24
Date last run: 2019-11-04 22:07:37

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio.biblionumber,
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">', "LINK", '</a>') AS LINK,
  biblio.author,
  biblio.title
FROM
  biblio
ORDER BY
  biblio.biblionumber DESC
  LIMIT 50

























