/*
R.002781

----------

Name: Sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-09-28 11:45:44
Modified on: 2021-09-03 14:37:28
Date last run: 2021-09-04 15:38:28

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  Concat(
    "<a href='/cgi-bin/koha/catalogue/detail.pl?biblionumber=", 
    biblio.biblionumber, 
    "' target='_blank'>go to the bibliographic record</a>"
  ) AS LINK,
  biblio.biblionumber,
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  plocs.lib AS PERMANENT_LOCATION,
  locs.lib AS LOCATION,
  ccodes.lib AS CCODE,
  itypes.description AS ITYPE,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    biblio.subtitle, 
    biblioitems.number,
    biblio.part_name
  ) AS FULL_TITLE,
  items.replacementprice
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber AND
      items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
  (SELECT
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib
   FROM
     authorised_values
   WHERE
     authorised_values.category = 'LOC') plocs ON plocs.authorised_value =
      items.permanent_location LEFT JOIN
  (SELECT
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib
   FROM
     authorised_values
   WHERE
     authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.location LEFT JOIN
  (SELECT
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib
   FROM
     authorised_values
   WHERE
     authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
     itemtypes.itemtype,
     itemtypes.description
   FROM
     itemtypes) itypes ON itypes.itemtype = items.itype
WHERE
  items.homebranch LIKE <<Item home library|ZBRAN>> AND
  ((items.barcode IS NULL) OR
    (plocs.lib IS NULL) OR
    (ccodes.lib IS NULL) OR
    (itypes.description IS NULL) OR
    (items.itemcallnumber IS NULL) OR
    (items.replacementprice IS NULL)
  ) AND
  Concat(
    If(items.barcode IS NULL, "B", ""), 
    If(plocs.lib IS NULL, "L3", ""), 
    If(ccodes.lib IS NULL, "C3", ""), 
    If(itypes.description IS NULL, "I3", ""), 
    If(items.itemcallnumber IS NULL, "N", ""), 
    If(items.replacementprice IS NULL, "P", "")
  ) LIKE CONCAT("%", <<Empty value in item record|XS_NULLS>>, "%")
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  PERMANENT_LOCATION,
  CCODE,
  ITYPE,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  FULL_TITLE



