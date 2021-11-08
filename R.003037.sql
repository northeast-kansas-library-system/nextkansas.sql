/*
R.003037

----------

Name: Title added
Created by: SABETHA TECH

----------

Group: Acquisitions
     Collection Development

Created on: 2018-01-12 10:51:47
Modified on: 2018-07-02 09:28:06
Date last run: 2021-11-02 12:24:24

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.dateaccessioned,
  items.barcode,
  biblio.title,
  biblio.author,
  items.holdingbranch
FROM
  items
  LEFT JOIN biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber
  LEFT JOIN biblio ON biblioitems.biblionumber = biblio.biblionumber
WHERE
  items.holdingbranch = 'SABETHA' AND
  biblio.datecreated >= '2017-01-02' AND
  biblio.datecreated <= '2018-01-02' AND
  items.ccode = 'FICTION' AND
  items.itype = 'BOOK' AND
  items.location = 'ADULT'
ORDER BY
  items.dateaccessioned

























