/*
R.002992

----------

Name: GHW - Call numbers with inappropriate space problems
Created by: George H Williams

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2017-09-01 14:01:00
Modified on: 2019-11-06 00:39:17
Date last run: 2023-01-06 10:07:58

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    '<a target="_blank" href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', 
    biblio.biblionumber, 
    '&itemnumber=', 
    items.itemnumber, 
    '\">', 
    'Edit item', 
    '</a>'
  ) AS Edit,
  Replace(items.itemcallnumber, ' ', '⋆') AS callnumber,
  Concat(
    '<a target="_blank" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio.biblionumber, 
    '\">', 
    biblio.title, 
    '</a>'
  ) AS Title,
  biblio.author,
  items.location AS location1,
  items.ccode AS ccode1,
  items.itype,
  items.barcode,
  biblio.biblionumber
FROM
  items
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
WHERE
  items.homebranch LIKE <<Choose item homebranch|LBRANCH>> AND
  ((items.itemcallnumber LIKE ' %'))
GROUP BY
  items.location,
  items.ccode,
  items.biblionumber
ORDER BY
  items.itemcallnumber

























