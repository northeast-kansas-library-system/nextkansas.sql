/*
R.003586

----------

Name: Identify records with mismatched 008 vs Copyright/Publication date 
Created by: -

----------

Group: -
     -

Created on: -
Modified on: 2021-10-12 16:22:00
Date last run: 2023-02-01 01:00:01

----------

Public: 0
Expiry: 300

----------

This report shows records that have a mismatch between the 008 publication date and the catalogued biblio.copyrightdate. This report can help identify records that have incorrect 008 fields so that the sorting by publication date remains consistent.

----------
*/



SELECT
  CONCAT('<a target="new" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">LINK</a>') AS LINK,
  eight.DATE,
  biblioitems.publicationyear
FROM
  biblio JOIN
  (SELECT
      biblio_metadata.biblionumber,
      SUBSTR(ExtractValue(biblio_metadata.metadata,
      '//controlfield[@tag="008"]'), 8, 4) AS DATE
    FROM
      biblio_metadata) eight ON eight.biblionumber = biblio.biblionumber
  JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber
WHERE
  eight.DATE <> biblioitems.publicationyear

























