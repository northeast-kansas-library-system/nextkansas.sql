/*
R.003589

----------

Name: LibraryIQ - Bibliographic File (deleted yesterday) - BONNERSPGS
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-13 08:30:10
Modified on: 2021-12-01 12:54:42
Date last run: 2022-03-23 00:15:04

----------

Public: 0
Expiry: 300

----------

#libraryiq #bibliographic #deleted #bonnerspgs #daily

----------
*/



SELECT
  deletedbiblio.biblionumber AS BibliographicRecordID,
  deletedbiblioitems.isbn AS ISBN,
  ExtractValue(deletedbiblio_metadata.metadata, '//datafield[@tag="024"]/subfield[@code="a"]') AS UPC,
  itemtypess.description AS `Material Type`,
  deletedbiblio.title AS Title,
  deletedbiblio.author AS Author,
  deletedbiblioitems.publicationyear `Publish Date`,
  deletedbiblioitems.publishercode Publisher,
  CurDate() AS `Report Date`
FROM
  deletedbiblio JOIN
  deletedbiblioitems ON deletedbiblioitems.biblionumber =
      deletedbiblio.biblionumber JOIN
  deletedbiblio_metadata ON deletedbiblio_metadata.biblionumber =
      deletedbiblio.biblionumber JOIN
  deleteditems ON deleteditems.biblionumber = deletedbiblio.biblionumber JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itemtypess ON itemtypess.itemtype = deleteditems.itype
WHERE
  deleteditems.homebranch = 'BONNERSPGS' AND
  Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 DAY) AND
  Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 DAY) AND
  Day(deleteditems.timestamp) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  deletedbiblio.biblionumber

























