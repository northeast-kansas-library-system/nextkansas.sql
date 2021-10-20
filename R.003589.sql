/*
R.003589

----------

Name: GHW - LibraryIQ - Bibliographic File - deleted yesterday
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-13 08:30:10
Modified on: 2021-10-13 11:14:25
Date last run: 2021-10-18 00:05:01

----------

Public: 0
Expiry: 300

----------

#libraryiq #bibliographic #bonnerspgs #daily 

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
  deleteditems.homebranch = 'BONNERSPGS' AND
  Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 DAY) AND
  Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 DAY) AND
  Day(deleteditems.timestamp) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  deleteditems.biblionumber

























