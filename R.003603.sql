/*
R.003603

----------

Name: LibraryIQ - Bibliographic File (full) - BONNERSPGS
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-10-29 16:39:24
Modified on: 2021-10-29 16:39:24
Date last run: 2021-10-29 16:41:45

----------

Public: 0
Expiry: 300

----------

Notes: #libraryiq #bibliographic #full #bonnerspgs #monthly 

----------
*/



SELECT
  items.biblionumber AS BibliographicRecordID,
  biblioitems.isbn AS ISBN,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="024"]/subfield[@code="a"]') AS UPC,
  itemtypes.description AS `Material Type`,
  biblio.title AS Title,
  biblio.author AS Author,
  biblioitems.publicationyear AS `Publish Date`,
  biblioitems.publishercode AS Publisher,
  CurDate() AS `Report Date`
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber  JOIN
  itemtypes ON itemtypes.itemtype = items.itype  JOIN
  biblioitems ON biblioitems.biblioitemnumber = biblio.biblionumber  JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  items.homebranch = 'BONNERSPGS'
GROUP BY
  items.biblionumber

























