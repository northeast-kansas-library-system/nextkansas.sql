/*
R.003619

----------

Name: LibraryIQ - Bibliographic file (full) - BASEHOR
Created by: George H Williams

----------

Group: LibraryIQ
     BASEHOR

Created on: 2021-11-08 11:31:52
Modified on: 2021-12-01 12:46:20
Date last run: 2022-03-20 01:00:03

----------

Public: 0
Expiry: 300

----------

#libraryiq #bibliographic #full #basehor #weekly

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
  items.homebranch = 'BASEHOR'
GROUP BY
  biblio.biblionumber

























