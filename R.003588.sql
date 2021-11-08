/*
R.003588

----------

Name: GHW - LibraryIQ - Bibliographic File - added yesterday - BONNERSPGS
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-13 08:15:38
Modified on: 2021-10-29 11:32:22
Date last run: 2021-11-08 00:10:02

----------

Public: 0
Expiry: 300

----------

#libraryiq #bibliographic #bonnerspgs #daily 

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
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  itemtypes ON itemtypes.itemtype = items.itype JOIN
  biblioitems ON biblioitems.biblioitemnumber = biblio.biblionumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  items.homebranch = 'BONNERSPGS' AND
  Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 DAY) AND
  Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 DAY) AND
  Day(items.dateaccessioned) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  items.biblionumber

























