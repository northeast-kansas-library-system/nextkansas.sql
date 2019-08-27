/*
R.002190

----------

Name: Itemnotes Field Has Data
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2014-02-12 15:06:45
Modified on: 2018-05-08 21:27:41
Date last run: 2019-08-06 14:28:58

----------

Public: 0
Expiry: 0

----------

Written for libraries to edit records with itemnotes data (public note for an item). Ordered by dateaccessioned, desc. Includes direct edit item link.

----------
*/

SELECT
  Concat(
    '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',
    biblio.biblionumber,
    '\" target="_blank">link to record</a>'
  ) AS LINK_TO_RECORD,
  items.dateaccessioned,
  biblio.title,
  biblio.author,
  items.itemnotes,
  items.barcode,
  Concat(
   '<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber='
   , biblio.biblionumber,
   '&itemnumber=',
    items.itemnumber, '#edititem\" target="_blank">Link to item</a>'
  ) AS EDIT_ITEM
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
WHERE
  items.homebranch LIKE <<Choose branch|LBRANCH>> AND
  items.itemnotes IS NOT NULL
ORDER BY
  items.dateaccessioned DESC



