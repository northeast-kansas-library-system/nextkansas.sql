/*
R.003639

----------

Name: GHW - Items potentially shelved at the wrong library
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-01-05 11:09:50
Modified on: 2022-03-29 12:16:48
Date last run: 2022-12-14 11:54:37

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  permanent_location.lib AS PERM_LOCATION,
  current_location.lib AS LOCATION,
  itypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  "2" AS SORTING
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') permanent_location ON
      permanent_location.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') current_location ON
      current_location.authorised_value = items.location LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypes ON itypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      branchtransfers.branchtransfer_id,
      branchtransfers.itemnumber,
      branchtransfers.datesent,
      branchtransfers.frombranch,
      branchtransfers.datearrived,
      branchtransfers.tobranch,
      branchtransfers.comments,
      branchtransfers.reason
    FROM
      branchtransfers
    WHERE
      branchtransfers.datearrived IS NULL) transfers ON transfers.itemnumber =
      items.itemnumber LEFT JOIN
  (SELECT
      reserves.reserve_id,
      reserves.borrowernumber,
      reserves.reservedate,
      reserves.biblionumber,
      reserves.branchcode,
      reserves.notificationdate,
      reserves.reminderdate,
      reserves.cancellationdate,
      reserves.reservenotes,
      reserves.priority,
      reserves.found,
      reserves.timestamp,
      reserves.itemnumber,
      reserves.waitingdate,
      reserves.expirationdate,
      reserves.lowestPriority,
      reserves.suspend,
      reserves.suspend_until,
      reserves.itemtype,
      reserves.item_level_hold
    FROM
      reserves
    WHERE
      reserves.found = 'W') onhold ON onhold.itemnumber = items.itemnumber
WHERE
  items.holdingbranch = <<Choose your library|branches>> AND
  items.homebranch <> items.holdingbranch AND
  items.itemlost < 1 AND
  items.withdrawn < 1 AND
  transfers.branchtransfer_id IS NULL AND
  items.onloan IS NULL AND
  onhold.reserve_id IS NULL
GROUP BY
  items.itemnumber
UNION
SELECT
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  permanent_location.lib AS PERM_LOCATION,
  current_location.lib AS LOCATION,
  itypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),  
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),  
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  "4" AS SORTING
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') permanent_location ON
      permanent_location.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') current_location ON
      current_location.authorised_value = items.location LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypes ON itypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      branchtransfers.branchtransfer_id,
      branchtransfers.itemnumber,
      branchtransfers.datesent,
      branchtransfers.frombranch,
      branchtransfers.datearrived,
      branchtransfers.tobranch,
      branchtransfers.comments,
      branchtransfers.reason
    FROM
      branchtransfers
    WHERE
      branchtransfers.datearrived IS NULL) transfers ON transfers.itemnumber =
      items.itemnumber LEFT JOIN
  (SELECT
      reserves.reserve_id,
      reserves.borrowernumber,
      reserves.reservedate,
      reserves.biblionumber,
      reserves.branchcode,
      reserves.notificationdate,
      reserves.reminderdate,
      reserves.cancellationdate,
      reserves.reservenotes,
      reserves.priority,
      reserves.found,
      reserves.timestamp,
      reserves.itemnumber,
      reserves.waitingdate,
      reserves.expirationdate,
      reserves.lowestPriority,
      reserves.suspend,
      reserves.suspend_until,
      reserves.itemtype,
      reserves.item_level_hold
    FROM
      reserves
    WHERE
      reserves.found = 'W') onhold ON onhold.itemnumber = items.itemnumber
WHERE
  items.homebranch = <<Choose your library|branches>> AND
  items.homebranch <> items.holdingbranch AND
  items.itemlost < 1 AND
  items.withdrawn < 1 AND
  transfers.branchtransfer_id IS NULL AND
  items.onloan IS NULL AND
  onhold.reserve_id IS NULL
GROUP BY
  items.itemnumber
UNION
SELECT
  " Owned by your library - at another library" AS Column1,
  "-" AS Column2,
  "-" AS Column3,
  "-" AS Column4,
  "-" AS Column5,
  "-" AS Column6,
  "-" AS Column7,
  "-" AS Column8,
  "-" AS Column9,
  "-" AS Column10,
  "-" AS Column11,
  "-" AS Column12,
  "3" AS SORTING
UNION
SELECT
  " At your library owned - owned by another library" AS Column1,
  "-" AS Column2,
  "-" AS Column3,
  "-" AS Column4,
  "-" AS Column5,
  "-" AS Column6,
  "-" AS Column7,
  "-" AS Column8,
  "-" AS Column9,
  "-" AS Column10,
  "-" AS Column11,
  "-" AS Column12,
  "1" AS SORTING
ORDER BY
  SORTING,
  holdingbranch,
  PERM_LOCATION,
  ITYPE,
  CCODE,
  itemcallnumber,
  copynumber,
  author,
  FULL_TITLE

























