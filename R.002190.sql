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
Date last run: 2025-08-06 11:56:56

----------

Public: 0
Expiry: 0

----------

Written for libraries to edit records with itemnotes data (public note for an item). Ordered by dateaccessioned, desc. Includes direct edit item link.

----------
*/



SELECT
  Concat(
    'link to record'
  ) AS LINK_TO_RECORD,
  items.dateaccessioned,
  biblio.title,
  biblio.author,
  items.itemnotes,
  items.barcode,
  Concat(
   'Link to item'
  ) AS EDIT_ITEM
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
WHERE
  items.homebranch LIKE <> AND
  items.itemnotes IS NOT NULL
ORDER BY
  items.dateaccessioned DESC

























