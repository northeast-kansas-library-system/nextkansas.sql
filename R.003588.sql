/*
R.003588

----------

Name: LibraryIQ - Bibliographic File (added yesterday) - BONNERSPGS
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-13 08:15:38
Modified on: 2021-12-01 12:48:49
Date last run: 2022-03-23 00:10:03

----------

Public: 0
Expiry: 300

----------

#libraryiq #bibliographic #added #bonnerspgs #daily

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
  items.homebranch = 'BONNERSPGS' AND
  Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 DAY) AND
  Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 DAY) AND
  Day(items.dateaccessioned) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  biblio.biblionumber

























