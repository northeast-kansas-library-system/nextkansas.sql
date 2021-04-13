/*
R.003287

----------

Name: GHW ADMINREPORT - Quick and Dirty
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-12-17 20:10:02
Modified on: 2019-12-17 20:10:02
Date last run: 2019-12-23 09:34:17

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', items.biblionumber, '\" target="_blank">', items.biblionumber, '</a>') AS LINK_TO_TITLE,
  items.biblionumber,
  items.itemnumber AS ITEM_NUMBER,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.homebranch,
  items.holdingbranch,
  Coalesce(items.location, "-") AS LOCATION,
  Coalesce(itypes.description, "-") AS ITYPE,
  Coalesce(ccodes.lib, "-") AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  biblioitems.publicationyear,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen,
  items.issues,
  items.renewals,
  Sum((Coalesce(items.issues, 0)) + (Coalesce(items.renewals, 0))) AS CHECKOUTS_PLUS_RENEWALS,
  If(items.onloan IS NULL, 'No', 'Yes') AS CHECKED_OUT,
  If(Sum(Coalesce(items.damaged, 0) + Coalesce(items.itemlost, 0) + Coalesce(items.withdrawn, 0)) = 0, 'No', 'Yes') AS STATUS_PROBLEMS,
  If(notloan.authorised_value = 0, "-", notloan.lib) AS NOT_FOR_LOAN,
  intransit.TRANSIT,
  items.itemnotes,
  items.itemnotes_nonpublic,
  items.copynumber,
  items.replacementprice,
  localcounts.Count_itemnumber AS LOCAL_COPIES,
  systemcounts.Count_itemnumber AS SYSTEM_COPIES,
  Concat('<a class= "clicked" href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', items.biblionumber, '&itemnumber=', items.itemnumber, '#edititem\" target="_blank">Edit item</a>') AS EDIT_ITEM
FROM
  items
  JOIN biblio
    ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata
    ON items.biblionumber = biblio_metadata.biblionumber
  JOIN biblioitems
    ON items.biblioitemnumber = biblioitems.biblioitemnumber
  JOIN (
    SELECT
      items.biblionumber,
      items.homebranch,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.biblionumber,
      items.homebranch
  ) localcounts
    ON items.biblionumber = localcounts.biblionumber AND
      items.homebranch = localcounts.homebranch
  JOIN (
    SELECT
      items.biblionumber,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.biblionumber
  ) systemcounts
    ON items.biblionumber = systemcounts.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value
  ) notloan
    ON notloan.authorised_value = items.notforloan
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode'
  ) ccodes
    ON ccodes.authorised_value = items.ccode
  LEFT JOIN (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
  ) itypes
    ON itypes.itemtype = items.itype
  LEFT JOIN (
    SELECT
      branchtransfers.itemnumber,
      If(branchtransfers.datearrived IS NULL, "Yes", "No") AS TRANSIT
    FROM
      branchtransfers
    WHERE
      branchtransfers.datearrived IS NULL
  ) intransit
    ON intransit.itemnumber = items.itemnumber
WHERE
  items.homebranch LIKE 'CORNING' AND
  Coalesce(items.location, "-") LIKE '%' AND
  Coalesce(items.itype, "XXX") LIKE '%' AND
  Coalesce(items.ccode, "XXX") LIKE '%' AND
  Coalesce(items.itemcallnumber, "-") LIKE Concat('%', "%") AND
  If(notloan.authorised_value = 0, "-", Concat(notloan.lib, "X")) LIKE '%' AND
  Coalesce(items.dateaccessioned, "0") <= '2019-12-18' AND
  Coalesce(items.datelastborrowed, "0") <= '2019-12-18' AND
  Coalesce(items.datelastseen, "0") <= '2019-12-18'
GROUP BY
  items.itemnumber,
  items.holdingbranch,
  intransit.TRANSIT,
  itypes.description,
  ccodes.lib
HAVING
  CHECKOUTS_PLUS_RENEWALS <= '999999999999' AND
  CHECKED_OUT LIKE '%' AND
  STATUS_PROBLEMS LIKE '%' AND
  LOCAL_COPIES >= '0' AND
  SYSTEM_COPIES >= '0'
ORDER BY
  items.homebranch,
  LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  biblio.title



