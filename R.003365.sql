/*
R.003365

----------

Name: GHW - List / virtualshelf report 005 - Display list titles with links to bibliographic records 
Created by: George Williams

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
  Concat('', biblio.title, '') AS TITLE
FROM
  biblio
  JOIN virtualshelfcontents
    ON biblio.biblionumber = virtualshelfcontents.biblionumber
WHERE
  virtualshelfcontents.shelfnumber LIKE &lt;&gt;
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.author,
  biblio.title

























