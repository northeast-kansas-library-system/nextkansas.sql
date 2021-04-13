/*
R.003365

----------

Name: GHW - List / virtualshelf report 005 - Display list titles with links to bibliographic records 
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-10 16:40:01
Modified on: 2020-11-10 16:52:40
Date last run: 2020-11-10 16:52:48

----------

Public: 0
Expiry: 300

----------

https://staff.nextkansas.org/cgi-bin/koha/catalogue/detail.pl?biblionumber=323043

----------
*/

SELECT
  biblio.author,
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">', biblio.title, '</a>') AS TITLE
FROM
  biblio
  JOIN virtualshelfcontents
    ON biblio.biblionumber = virtualshelfcontents.biblionumber
WHERE
  virtualshelfcontents.shelfnumber LIKE <<Enter list number>>
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.author,
  biblio.title



