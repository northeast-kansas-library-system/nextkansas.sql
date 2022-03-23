/*
R.003612

----------

Name: LibraryIQ - Bibliographic File (deleted yesterday) - BASEHOR
Created by: George H Williams

----------

Group: LibraryIQ
     BASEHOR

Created on: 2021-11-08 11:06:08
Modified on: 2021-11-12 11:39:52
Date last run: 2022-03-23 00:10:03

----------

Public: 0
Expiry: 300

----------

#libraryiq #bibliographic #deleted #basehor #daily 

----------
*/



SELECT
  deleteditems.biblionumber AS BibliographicRecordID,
  deletedbiblioitems.isbn AS ISBN,
  ExtractValue(deletedbiblio_metadata.metadata, '//datafield[@tag="024"]/subfield[@code="a"]') AS UPC,
  itemtypes.description AS `Material Type`,
  deletedbiblio.title AS Title,
  deletedbiblio.author AS Author,
  deletedbiblioitems.publicationyear AS `Publish Date`,
  deletedbiblioitems.publishercode AS Publisher,
  CurDate() AS `Report Date`
FROM
  deleteditems  JOIN
  deletedbiblio ON deletedbiblio.biblionumber = deleteditems.biblionumber
   JOIN
  itemtypes ON itemtypes.itemtype = deleteditems.itype  JOIN
  deletedbiblio_metadata ON deletedbiblio_metadata.biblionumber =
      deletedbiblio.biblionumber  JOIN
  deletedbiblioitems ON deletedbiblioitems.biblionumber =
      deletedbiblio.biblionumber
WHERE
  deleteditems.homebranch = 'BASEHOR' AND
  Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 DAY) AND
  Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 DAY) AND
  Day(deleteditems.timestamp) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  deleteditems.biblionumber

























