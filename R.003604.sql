/*
R.003604

----------

Name: LibraryIQ - non local biblios for requests - all
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-11-01 00:05:32
Modified on: 2021-11-01 00:24:52
Date last run: 2021-11-01 00:24:55

----------

Public: 0
Expiry: 300

----------



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
  CurDate() AS `Report Date`,
  Group_Concat(DISTINCT items.homebranch) AS homebranches
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  itemtypes ON itemtypes.itemtype = items.itype JOIN
  biblioitems ON biblioitems.biblioitemnumber = biblio.biblionumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  INNER JOIN
  (SELECT
     reserves.biblionumber AS BibRecordID,
     reserves.branchcode AS Branch,
     rcounts.Count_reserve_id AS `Number of Requests`,
     CurDate() AS `Report Date`
   FROM
     reserves LEFT JOIN
     (SELECT
        reserves.biblionumber,
        Count(reserves.reserve_id) AS Count_reserve_id
      FROM
        reserves
      GROUP BY
        reserves.biblionumber) rcounts ON rcounts.biblionumber =
         reserves.biblionumber
   WHERE
     reserves.branchcode = 'BONNERSPGS'
   GROUP BY
     reserves.biblionumber,
     reserves.branchcode,
     rcounts.Count_reserve_id) requestsdata ON requestsdata.BibRecordID =
      items.biblionumber
GROUP BY
  items.biblionumber
HAVING
  Group_Concat(DISTINCT items.homebranch) NOT LIKE "%BONNERSPGS%"

























