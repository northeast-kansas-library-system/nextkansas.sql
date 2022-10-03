/*
R.003602

----------

Name: LibraryIQ - Bibliographic File (full) - BONNERSPGS
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-29 16:34:48
Modified on: 2021-12-01 12:31:40
Date last run: 2022-04-17 00:50:02

----------

Public: 0
Expiry: 300

----------

#libraryiq #bibliographic #full #bonnerspgs #weekly

----------
*/



SELECT
  biblio.biblionumber AS BibliographicRecordID,
  biblioitems.isbn AS ISBN,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="024"]/subfield[@code="a"]') AS UPC,
  itemtypess.description AS `Material Type`,
  biblio.title AS Title,
  biblio.author AS Author,
  biblioitems.publicationyear `Publish Date`,
  biblioitems.publishercode Publisher,
  CurDate() AS `Report Date`
FROM
  biblio JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber JOIN
  items ON items.biblionumber = biblio.biblionumber JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itemtypess ON itemtypess.itemtype = items.itype
WHERE
  items.homebranch = 'BONNERSPGS'
GROUP BY
  biblio.biblionumber

























