/*
R.003285

----------

Name: 942 search
Created by: George Williams

----------

Group: -
     -

Created on: 2019-12-07 21:24:12
Modified on: 2019-12-10 16:19:16
Date last run: 2026-03-03 10:39:10

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Link</a>') AS LINK_TO_TITLE,
  biblio.biblionumber,
  biblio.title,
  biblio.author,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') AS H,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') AS RITYPE
FROM
  biblio
  JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') LIKE Concat("%", <<Enter bibliographic record itype>> ,"%")
GROUP BY
  biblio.biblionumber,
  biblio.datecreated
ORDER BY
  biblio.biblionumber DESC

























