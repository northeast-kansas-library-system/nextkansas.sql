/*
R.001368

----------

Name: Bib Search By Author sorted by title
Created by: Heather Braum

----------

Group: -
     -

Created on: 2012-05-02 00:38:22
Modified on: 2018-07-02 12:13:26
Date last run: 2019-03-11 22:49:38

----------

Public: 0
Expiry: 0

----------

Enhanced -- enter author name. For catalog cleanup

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">LINK</a>') AS LINK,
  biblio.biblionumber,
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code>="h"]') AS MEDIUM,
  biblio.author,
  Count(items.itemnumber),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="020"]/subfield[@code>="a"]') AS ISBNA,
  biblioitems.pages,
  biblioitems.size,
  biblioitems.publishercode,
  biblioitems.publicationyear
FROM
  biblio
  JOIN items ON biblio.biblionumber = items.biblionumber
  LEFT JOIN biblioitems ON items.biblionumber = biblioitems.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  biblio.author LIKE Concat("%", <<author>>,"%") AND
  (items.itype <> 'AUDIOBOOK' AND
   items.itype <> 'MEDIA')
GROUP BY
  biblio.biblionumber
HAVING
  Count(items.itemnumber) > 0
ORDER BY
  biblio.title,
  biblioitems.pages,
  biblioitems.publishercode

























