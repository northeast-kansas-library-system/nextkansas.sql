/*
R.003607

----------

Name: LibraryIQ - Item File (full) - BASEHOR
Created by: George H Williams

----------

Group: LibraryIQ
     BASEHOR

Created on: 2021-11-08 10:51:34
Modified on: 2021-11-12 11:37:57
Date last run: 2022-03-20 00:50:03

----------

Public: 0
Expiry: 300

----------

#libraryiq #item #full #basehor #weekly

----------
*/



SELECT
  items.itemnumber AS RecordID,
  items.barcode AS Barcode,
  items.biblionumber AS BibRecordID,
  biblioitems.isbn AS ISBN,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="024"]/subfield[@code="a"]') AS UPC,
  Concat_Ws(' | ', 
    items.permanent_location, 
    itemtypes.description,
    ccodes.lib
  ) AS `Collection Code`,
  itemtypes.description AS `Material Type`,
  items.holdingbranch AS `Branch Location`,
  items.homebranch AS `Owning Branch`,
  items.itemcallnumber AS `Call Number`,
  locs.lib AS `Shelf Location`,
  items.dateaccessioned AS ItemCreationDate,
  Concat_Ws(" ", 
    nfl.lib, 
    damageds.lib, 
    losts.lib, 
    withdrawns.lib, 
    if(items.onloan > 0, "Checked out", "")
  ) AS `Current Item Status`,
  items.datelastborrowed AS `Last Checkout Date`,
  items.datelastseen AS `Check In Date`,
  items.onloan AS `Due Date`,
  statisticss.Count_datetime AS `YTD Circ Count`,
  (Coalesce(items.issues, 0) + Coalesce(items.renewals, 0)) AS `Lifetime Circ Count`,
  CurDate() AS `Report Date`
FROM
  items JOIN
  biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = items.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode JOIN
  itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'not_loan') nfl ON nfl.authorised_value =
      items.notforloan LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'damage') damageds ON
      damageds.authorised_value = items.damaged LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'lost') losts ON losts.authorised_value =
      items.itemlost LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'withdrawn') withdrawns ON
      withdrawns.authorised_value = items.withdrawn LEFT JOIN
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
      items.itemnumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc') locs ON locs.authorised_value =
      items.permanent_location
WHERE
  items.homebranch = 'BASEHOR'
GROUP BY
  items.itemnumber

























