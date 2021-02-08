/*
R.003407

----------

Name: koha-US test 2201
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-01-15 13:39:41
Modified on: 2021-01-15 13:58:02
Date last run: 2021-01-25 10:12:48

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    items.biblionumber, 
    '\" target="_blank">', 
    items.biblionumber, 
    '</a>'
  ) AS LINK_TO_TITLE,
  items.biblionumber,
  items.itemnumber AS ITEM_NUMBER,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.homebranch,
  items.holdingbranch,
  Coalesce(locs.lib, "-") AS LOCATION,
  Coalesce(itypes.description, "-") AS ITYPE,
  Coalesce(ccodes.lib, "-") AS CCODE,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  biblio.title,
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', 
    items.biblionumber, 
    '&itemnumber=', 
    items.itemnumber, 
    '#edititem\" target="_blank">Edit item</a>'
  ) AS EDIT_ITEM
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber JOIN
  biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
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
      itemtypes) itypes ON itypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.location
WHERE
  items.homebranch = <<Choose your library|branches>> AND
  items.itype = <<Choose an item type|itemtypes:all>>
GROUP BY
  items.itemnumber,
  Coalesce(locs.lib, "-"),
  biblio.biblionumber
ORDER BY
  items.homebranch,
  LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.copynumber



