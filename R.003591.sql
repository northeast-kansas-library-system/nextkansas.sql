/*
R.003591

----------

Name: LibraryIQ - Item File (deleted yesterday) - BONNERSPGS
Created by: George H Williams

----------

Group: LibraryIQ
     BONNERSPGS

Created on: 2021-10-13 10:20:01
Modified on: 2021-11-12 12:02:40
Date last run: 2022-04-20 00:25:03

----------

Public: 0
Expiry: 300

----------

#libraryiq #item #deleted #bonnerspgs #daily

----------
*/



SELECT
  deleteditems.itemnumber AS RecordID,
  deleteditems.barcode AS Barcode,
  deleteditems.biblionumber AS BibRecordID,
  Coalesce(biblioitems.isbn, deletedbiblioitems.isbn) AS ISBN,
  Coalesce(
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="024"]/subfield[@code="a"]'), 
    ExtractValue(deletedbiblio_metadata.metadata, '//datafield[@tag="024"]/subfield[@code="a"]')
  ) AS UPC,
  Concat_Ws(' | ', 
    deleteditems.permanent_location, 
    itemtypes.description,
    ccodes.lib
  ) AS `Collection Code`,
  itemtypes.description AS `Material Type`,
  deleteditems.holdingbranch AS `Branch Location`,
  deleteditems.homebranch AS `Owning Branch`,
  deleteditems.itemcallnumber AS `Call Number`,
  locs.lib AS `Shelf Location`,
  deleteditems.dateaccessioned AS ItemCreationDate,
  Concat_Ws(" ", 
    nfl.lib, 
    damageds.lib, 
    losts.lib, 
    withdrawns.lib,
    if(deleteditems.onloan > 0, "Checked out", "")
  ) AS `Current Item Statusdeleteditems.onloan`,
  deleteditems.datelastseen AS `Check In Date`,
  deleteditems.onloan AS `Due Date`,
  statisticss.Count_datetime AS `YTD Circ Count`,
  (Coalesce(deleteditems.issues, 0) + Coalesce(deleteditems.renewals, 0)) AS `Lifetime Circ Count`,
  CurDate() AS `Report Date`
FROM
  deleteditems LEFT JOIN
  biblioitems ON deleteditems.biblioitemnumber = biblioitems.biblioitemnumber
  LEFT JOIN
  biblio_metadata ON biblio_metadata.biblionumber = deleteditems.biblionumber
  LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      deleteditems.ccode JOIN
  itemtypes ON itemtypes.itemtype = deleteditems.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'not_loan') nfl ON nfl.authorised_value =
      deleteditems.notforloan LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'damage') damageds ON
      damageds.authorised_value = deleteditems.damaged LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'lost') losts ON losts.authorised_value =
      deleteditems.itemlost LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'withdrawn') withdrawns ON
      withdrawns.authorised_value = deleteditems.withdrawn LEFT JOIN
  (SELECT
      statistics.itemnumber,
      Count(statistics.datetime) AS Count_datetime,
      statistics.type
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      statistics.datetime > CurDate() - INTERVAL 1 YEAR
    GROUP BY
      statistics.itemnumber) statisticss ON statisticss.itemnumber =
      deleteditems.itemnumber LEFT JOIN
  deletedbiblioitems ON deletedbiblioitems.biblioitemnumber =
      deleteditems.biblioitemnumber LEFT JOIN
  deletedbiblio_metadata ON deletedbiblio_metadata.biblionumber =
      deleteditems.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc') locs ON locs.authorised_value =
      deleteditems.permanent_location
WHERE
  deleteditems.homebranch = 'BONNERSPGS' AND
  Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 DAY) AND
  Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 DAY) AND
  Day(deleteditems.timestamp) = Day(Now() - INTERVAL 1 DAY)
GROUP BY
  deleteditems.itemnumber

























