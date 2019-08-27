/*
R.001261

----------

Name: Bib Search By Author (sorted by isbn first)
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2011-12-13 23:30:13
Modified on: 2017-12-11 10:20:59
Date last run: 2017-12-11 10:22:08

----------

Public: 0
Expiry: 0

----------

Enhanced -- enter author name. For catalog cleanup

----------
*/

SELECT DISTINCT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">',
  biblio.biblionumber, '</a>') AS LINK,
  biblio.title,
  biblio.author,
  Count(items.itemnumber) AS ITEM_COUNT,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="020"]/subfield[@code>="a"]') AS ISBN_A,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="020"]/subfield[@code>="z"]') AS ISBN_Z,
  biblioitems.pages,
  biblioitems.size,
  biblioitems.publishercode,
  biblioitems.publicationyear,
 Concat('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=kw&q=', biblio.title,'&op=and&idx=au&q=',biblio.author,'&sort_by=title_az\" target="_blank">SEARCH THIS TITLE</a>') AS SEARCH_THIS_TITLE,
  items.biblionumber
FROM
  biblio
  LEFT JOIN biblioitems ON biblio.biblionumber = biblioitems.biblionumber
  LEFT JOIN items ON biblioitems.biblionumber = items.biblionumber
  LEFT JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  biblio.author LIKE CONCAT("%",<<Enter author's name>>,"%")
GROUP BY
  items.biblionumber,
  biblio.biblionumber
HAVING
  Count(items.itemnumber) > 0
ORDER BY
  biblio.title,
  biblioitems.publishercode,
  biblioitems.publicationyear,
  biblioitems.pages



