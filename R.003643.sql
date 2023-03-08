/*
R.003643

----------

Name: GHW - ADMINREPORT - GMD search
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-01-19 17:05:04
Modified on: 2022-01-20 08:51:38
Date last run: 2023-02-28 11:20:55

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio.biblionumber,
  biblio.author,
  biblio.title,
  biblio.medium,
  Concat(
    '<a class="btn btn-default" href=\"/cgi-bin/koha/cataloguing/addbiblio.pl?biblionumber=',
    biblio.biblionumber,
    '" target="_blank">Link</a>'
  ) AS LINK
FROM
  biblio
WHERE
  biblio.medium LIKE concat('%', <<Enter search term>>, '%')
ORDER BY
  biblio.medium

























